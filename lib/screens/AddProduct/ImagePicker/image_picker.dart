import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class MultipleImagePicker extends StatelessWidget {
  MultipleImagePicker({super.key, required this.notifyParent, required this.images});

  final ValueChanged<List<Asset>> notifyParent;
  List<Asset> images = <Asset>[];

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
      notifyParent(resultList);
    // ignore: empty_catches
    } on Exception {
    }
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
      ],
    );
  }
}