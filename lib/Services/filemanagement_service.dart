import 'package:file_picker/file_picker.dart';
import 'package:filepicker/Model/selectedfiles_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import '../Controller/filemanagenement_controller.dart';

FileManagementController fileManagementController =
    Get.put(FileManagementController());

//SinglePicture Management
Future picManagement(BuildContext context) async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);
  fileManagementController.isLoading.value = true;

  if (result != null) {
    PlatformFile file = result.files.first;

    if (file.size > 5 * 1024 * 1024) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("The selected image exceeds the size limit of 5 MB.")),
      );
    } else {
      fileManagementController.managedFiles.add(
        ManagedFiles(
          name: file.name,
          originalSize: file.size,
          compressedSize: file.size,
          // For images, original size and compressed size are the same
          path: file.path!,
          type: 'image',
        ),
      );
    }
  }
  await Future.delayed(const Duration(seconds: 1));
  fileManagementController.isLoading.value = false;
}

//CompressedVideo Management
Future vidManagement(BuildContext context) async {
  fileManagementController.isLoading.value = true;
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.video);

  if (result != null) {
    PlatformFile file = result.files.first;

    // Compressing video
    if (fileManagementController.isCompressing.value == false) {
      fileManagementController.isCompressing.value = true;
      MediaInfo? compressedVideo = await VideoCompress.compressVideo(file.path!,
          quality: VideoQuality.LowQuality, includeAudio: true);
      fileManagementController.isCompressing.value = false;

      if (compressedVideo != null) {
        // Adding compressed video to the list
        fileManagementController.managedFiles.add(
          ManagedFiles(
            name: file.name.split('/').last,
            originalSize: file.size,
            compressedSize: compressedVideo.filesize ?? 0,
            path: compressedVideo.path!,
            type: 'video',
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to compress video.")),
        );
      }
    }
  }

  fileManagementController.isLoading.value = false;
}

//MultiPicture Management
Future multiPicManagement(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.image, allowMultiple: true);

  fileManagementController.isLoading.value = true;

  if (result != null) {
    List<ManagedFiles> validFiles = [];

    for (var file in result.files) {
      if (file.size > 5 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("At least one picture exceeds the size limit of 5 MB.")),
        );
      } else {
        validFiles.add(
          ManagedFiles(
            name: file.name,
            originalSize: file.size,
            compressedSize: file.size,
            path: file.path!,
            type: 'image',
          ),
        );
      }
    }

    fileManagementController.managedFiles.addAll(validFiles);
  }

  await Future.delayed(const Duration(seconds: 1));
  fileManagementController.isLoading.value = false;
}
