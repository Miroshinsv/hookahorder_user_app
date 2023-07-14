import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/models/order/order_model.dart';
import 'package:hookahorder_mobile/app/models/user_model/user_model.dart';
import 'package:hookahorder_mobile/app/services/auth_service.dart';
import 'package:hookahorder_mobile/app/services/order_service.dart';
import 'package:hookahorder_mobile/app/services/user_service.dart';

class ProfileScreenController extends GetxController {
  final TextEditingController userFirstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Rxn<UserModel> currentUser = Rxn();
  RxList<OrderModel> myOrders = RxList();
  final UserService _userService = Get.find();
  final OrderService _orderService = Get.find();
  final AuthorizeService _authorizeService = Get.find();

  ProfileScreenController() {
    getMyOrders();
  }

  Future<UserModel> getUserById() async {
    currentUser.value =
        await _userService.getUserById(await _authorizeService.getUserId());
    userFirstNameController.text = currentUser.value?.getName ?? "";
    emailController.text = currentUser.value?.getEmail ?? "";
    return currentUser.value!;
  }

  Future<List<OrderModel>?> getMyOrders() async {
    myOrders.value = await _orderService.getMyOrders();
    return myOrders;
  }

  Future<void> logout() async {
    await _authorizeService.logOut();
  }

  Future<bool> saveChanges() async {
    try {
      final resp = await _userService.updateUser(
          await _authorizeService.getUserId(),
          userFirstNameController.text,
          emailController.text);
      FocusScope.of(Get.context!).unfocus();
      currentUser.value = resp;
      return true;
    } catch (e) {
      return false;
    }
  }
}
