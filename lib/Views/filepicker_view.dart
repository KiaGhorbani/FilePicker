import 'dart:io';
import 'package:filepicker/Components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Components/AppBar/appbar_checkbox.dart';
import '../Components/loading.dart';
import '../Controller/filemanagenement_controller.dart';
import 'imagepreview_view.dart';

RxBool isChecked = false.obs;

class Filepicker extends StatelessWidget {
  const Filepicker({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FileManagementController());
    final fileManagementController = Get.find<FileManagementController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            ABcheckbox(label: "Select Multiple Pictures", ischecked: isChecked),
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  // Button for Pictures
                  PicturePicker(buttontext: "Press to pick picture"),

                  SizedBox(width: 10),

                  // Button for Videos
                  VideoPicker(buttontext: "Press to pick video"),
                ],
              ),
              const SizedBox(height: 50),
              // Compressing Progress Indicator
              Obx(() {
                if (fileManagementController.isCompressing.value) {
                  return const Column(
                    children: [
                      Text("Compressing..."),
                      SizedBox(
                        height: 10,
                      ),
                      CompressLoading(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Be Patient, this action might take time..."),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              const SizedBox(height: 50),
              Expanded(
                child: Obx(() {
                  if (fileManagementController.isLoading.value) {
                    return const Loading();
                  }
                  if (fileManagementController.managedFiles.isEmpty) {
                    return const Center(child: Text("No files selected"));
                  } else {
                    return GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: fileManagementController.managedFiles.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        // ManagedFiles file = fileManagementController.managedFiles[index];

                        if (fileManagementController.managedFiles[index].type ==
                            'image') {
                          // Display image
                          return GestureDetector(
                            onTap: () {
                              Get.to(Imagepreview(
                                  image: fileManagementController
                                      .managedFiles[index].path));
                            },
                            child: Image.file(
                              File(fileManagementController
                                  .managedFiles[index].path),
                              fit: BoxFit.cover,
                            ),
                          );
                        } else if (fileManagementController
                                .managedFiles[index].type ==
                            'video') {
                          // Display video details
                          return SizedBox(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      fileManagementController
                                          .managedFiles[index].name,
                                      maxLines: 1),
                                  Text(
                                      "OSize: ${(fileManagementController.managedFiles[index].originalSize / (1024 * 1024)).toStringAsFixed(1)}",
                                      maxLines: 1),
                                  Text(
                                      "CSize: ${(fileManagementController.managedFiles[index].compressedSize / (1024 * 1024)).toStringAsFixed(2)}"),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
