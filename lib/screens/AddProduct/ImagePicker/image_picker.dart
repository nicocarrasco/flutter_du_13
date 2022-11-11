
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImagePicker extends StatelessWidget {

  MultipleImagePicker({super.key, required this.notifyParent});

  final ValueChanged<XFile> notifyParent;

  final ImagePicker imgpicker = ImagePicker();



  Future<void> pickImage() async {
    final XFile? image = await imgpicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      notifyParent(image);
    }
  }

  Future<void> takePicture() async {
    final XFile? photo = await imgpicker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      notifyParent(photo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        if (!kIsWeb)
        ElevatedButton.icon(
          onPressed: takePicture,
          icon: const Icon(
            Icons.photo_camera,
            color: Colors.white,
            size: 30.0,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          label: const Text("Prendre une photo"),
        ),
        if (!kIsWeb)
        const SizedBox(height: 20,),
        ElevatedButton.icon(
          onPressed: pickImage,
          icon: const Icon(
            Icons.image,
            color: Colors.white,
            size: 30.0,
          ),
          style: ElevatedButton.styleFrom(
           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15),
           ),
         ),
          label: const Text("Ajouter depuis la gallerie"),
        ),
      ],
    );
  }
}