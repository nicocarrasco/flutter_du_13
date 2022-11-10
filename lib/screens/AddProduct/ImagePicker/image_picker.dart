import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class MultipleImagePicker extends StatefulWidget {
  const MultipleImagePicker({super.key});

  @override
  State<MultipleImagePicker> createState() => _MultipleImagePickerState();
}

class _MultipleImagePickerState extends State<MultipleImagePicker> {
  List<Asset> images = <Asset>[];

  @override
  void initState() {
    super.initState();
  }


  Widget buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 30,
        crossAxisSpacing: 24,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (BuildContext context, int index) =>
      AssetThumb(
          asset: images[index],
          width: 150,
          height: 150,
      ),
      itemCount: images.length,
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
        takePhotoIcon: "photo_camera",
        doneButtonTitle: "Fini",),
        materialOptions: const MaterialOptions(
          actionBarColor: "#FF72B2D5",
          actionBarTitle: "Vos photos",
          allViewTitle: "Toutes les photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    // ignore: empty_catches
    } on Exception {
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: loadAssets,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  end: Alignment(2.5, 2.5),
                  colors: <Color>[primaryDarkerColor, primaryLighterColor],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 17),
                  child: Text(
                    'Ajouter des photos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: images.isNotEmpty ? 150 : 0,
          width: images.isNotEmpty ?  MediaQuery.of(context).size.width : 0,
          child: Expanded(
            child:  buildGridView(),
        ),
        )
      ],
    );
  }
}
