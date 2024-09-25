import 'package:flutter/material.dart';

import '../Services/filemanagement_service.dart';
import '../Views/filepicker_view.dart';

class PicturePicker extends StatelessWidget {
  const PicturePicker({super.key, required this.buttontext});

  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {

        if (isChecked.value == false) {
          await picManagement(context);
        } else {
          await multiPicManagement(context);
        }


      },
      child: Text(buttontext),
    );
  }
}

class VideoPicker extends StatelessWidget {
  const VideoPicker({super.key, required this.buttontext});

  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await vidManagement(context);
      },
      child: Text(buttontext),
    );
  }
}
