import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/routes/route_config.dart';
import 'package:hookahorder_mobile/app/ui/screen/profile_screen/profile_screen_controller.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          if (controller.currentUser.value == null) {
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
                      Text("Ваш ID: ${controller.currentUser.value!.getId}"),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        initialValue:
                            "+${controller.currentUser.value!.getPhone}",
                        style: const TextStyle(color: Colors.grey),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: "+7##########")
                        ],
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
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: controller.userFirstNameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          label: const Text(
                            "Имя",
                            style: TextStyle(color: Colors.grey),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: controller.currentUser.value?.getName ??
                              "Введите имя",
                          fillColor: Colors.white70,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          label: const Text(
                            "Email",
                            style: TextStyle(color: Colors.grey),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: controller.currentUser.value?.getName ??
                              "Введите ваш email",
                          fillColor: Colors.white70,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 4),
                      const Text(
                        "Мои заказы",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (controller.myOrders.isEmpty)
                        const Text(
                          "Заказов нет",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      else
                        FlutterCarousel(
                          options: CarouselOptions(
                            height: 180,
                            showIndicator: false,
                            slideIndicator: const CircularSlideIndicator(),
                          ),
                          items: controller.myOrders.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 4),
                                        Text(
                                          i.getPlace.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        CircleAvatar(
                                            backgroundImage: const AssetImage(
                                                "assets/icons/empty_logo.png"),
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8),
                                        const SizedBox(height: 4),
                                        Text(
                                            "Заказ от ${DateFormat('dd-MM-yyyy').format(i.getCreatedAt)}"),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: "Статус заказа "),
                                              TextSpan(
                                                text: i.getOrderStatus ??
                                                    "Завершен",
                                                style: TextStyle(
                                                    color: i.getOrderStatus ==
                                                                null ||
                                                            i.getOrderStatus ==
                                                                "Завершен"
                                                        ? Colors.green
                                                        : Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: controller.saveChanges,
                            style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(39, 129, 129, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Сохранить",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await controller.logout();
                              Get.offNamed(RouteConfig.MAIN_SCREEN);
                            },
                            style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(39, 129, 129, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
