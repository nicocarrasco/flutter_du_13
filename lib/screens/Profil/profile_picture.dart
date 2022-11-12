import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilPicture extends StatefulWidget {
  const ProfilPicture({Key? key}) : super(key: key);

  @override
  State<ProfilPicture> createState() => _ProfilPictureState();
}

class _ProfilPictureState extends State<ProfilPicture> {
  String? _picture;
  final ImagePicker imgpicker = ImagePicker();
  final UserProvider model = UserProvider();
  bool _isLoading = false;

  void _listener() async {
    final String picture =
        await Provider.of<UserProvider>(context, listen: false).getPicture();
    if (_picture != picture) {
      setState(() {
        _picture = picture;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    model.addListener(_listener);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    final String picture =
        await Provider.of<UserProvider>(context, listen: false).getPicture();
    setState(() {
      _picture = picture;
    });
  }

  Future<void> pickImage() async {
    final XFile? image = await imgpicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _isLoading = true;
      });
      if (!mounted) return;
      final String message = await Provider.of<UserProvider>(
        context,
        listen: false,
      ).updatePicture(
        picture: image,
      );
      final bool isError = message != "L'image de profil a été mise à jour";
      if (isError) {
        setState(() {
          _isLoading = false;
        });
      }
      await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: isError ? errorColor : primaryColor,
        webBgColor: "#72B2D5",
        webShowClose: true,
        webPosition: "center",
        textColor: backgroundLighterColor,
        fontSize: 16.0,
        timeInSecForIosWeb: 2,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          if (_isLoading)
            Container(
              margin: const EdgeInsets.all(20),
              width: 100,
              height: 100,
              child: const Center(child: CircularProgressIndicator()),
            )
          else
            Container(
              margin: const EdgeInsets.all(20),
              width: 100,
              height: 100,
              decoration: _picture != null
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(_picture!),
                        fit: BoxFit.fill,
                      ),
                    )
                  : null,
            ),
          TextButton(
            onPressed: pickImage,
            child: const Text(
              "Modifiez votre photo de profil",
              style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
                color: primaryDarkerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
