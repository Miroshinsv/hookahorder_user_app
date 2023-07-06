import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/routes/route_config.dart';
import 'package:hookahorder_mobile/app/ui/screen/profile_screen/profile_screen_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (controller.currenUser.value == null) {
            controller.getUserById();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset("assets/icons/empty_logo.png").image,
                        radius: 80.0,
                      ),
                      const Divider(),
                      Text("ID: ${controller.currenUser.value!.getId}"),
                      const SizedBox(height: 5,),
                      TextFormField(
                        initialValue: "+${controller.currenUser.value!.getPhone}",
                        style: const TextStyle(color: Colors.grey),
                        keyboardType: TextInputType.number,
                        inputFormatters: [ MaskTextInputFormatter(mask: "+7##########")],
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          enabled: false,
                          label: Text(
                            "Телефон",
                            style: TextStyle(color: Colors.grey),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        initialValue: controller.currenUser.value?.getName,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          label: const Text(
                            "Имя",
                            style: TextStyle(color: Colors.grey),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: controller.currenUser.value?.getName ??
                              "Введите имя",
                          fillColor: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        initialValue: controller.currenUser.value?.getEmail,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          label: const Text(
                            "Email",
                            style: TextStyle(color: Colors.grey),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: controller.currenUser.value?.getName ??
                              "Введите ваш email",
                          fillColor: Colors.white70,
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () async {
                          await controller.logout();
                          Get.offNamed(RouteConfig.MAIN_SCREEN);
                        },
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(39, 129, 129, 1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Выйти",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
