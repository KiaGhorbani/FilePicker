import 'package:filepicker/Model/selectedfiles_model.dart';
import 'package:get/get.dart';

class FileManagementController extends GetxController {
  RxList<ManagedFiles> managedFiles = <ManagedFiles>[].obs;

  RxBool isLoading = false.obs;
  RxBool isCompressing = false.obs;
}
