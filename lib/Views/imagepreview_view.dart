import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../Components/AppBar/appbar_icons.dart';

class Imagepreview extends StatelessWidget {
  const Imagepreview({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            //Icon For Getting Back To Pick files page
            leading: const Backicon()),
        backgroundColor: Colors.black,
        body: Center(
          //Photo View Package Used Because i Wanted to zoom :}
          child: PhotoView(
            imageProvider: FileImage(File(image)),
            backgroundDecoration: const BoxDecoration(color: Colors.black),

            // enableRotation: true,
          ),
        ),
      ),
    );
  }
}
