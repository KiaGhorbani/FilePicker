import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';


//Appbar back arrow for returning to the previous page
class Backicon extends StatelessWidget {
  const Backicon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: Get.back,
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ));
  }
}


