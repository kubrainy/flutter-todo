import 'package:get/get.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserController extends GetxController {
  final UserService _service = UserService();

  final users = <User>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;

  @override
  void onInit(){
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      error.value = '';
      users.assignAll(await _service.fetchUsers());
    } catch(e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}