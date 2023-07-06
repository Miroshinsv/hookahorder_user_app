import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hookahorder_mobile/app/ui/screen/main_screen/main_screen_controller.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final MaskTextInputFormatter formatter =
    MaskTextInputFormatter(mask: "+7##########");
final MainScreenController controller = Get.find();

AlertDialog needAuthDialog() {
  return AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Для оформления бронирования необходимо авторизоваться",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const Divider(),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Get.back();
                Get.dialog(authDialog());
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  Color.fromRGBO(39, 129, 129, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Авторизация",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Get.back();
                Get.dialog(registerDialog());
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(39, 129, 129, 1),
                    ),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Регистрация",
                  style: TextStyle(color: Color.fromRGBO(39, 129, 129, 1)),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

AlertDialog successOrder() {
  return AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          child: Icon(
            Icons.check,
            color: Colors.green,
            size: Get.mediaQuery.size.width * 0.1,
          ),
        ),
        const Divider(),
        const Text(
          "Заказ оформлен",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

AlertDialog placeOrderDialog() {
  return AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Оформить заказ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Я буду в ",
                  style: TextStyle(color: Colors.white),
                ),
                Builder(
                  builder: (context) => TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color.fromRGBO(39, 129, 129, 1),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      var datetime = await showIntervalTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                        interval: 5,
                        visibleStep: VisibleStep.fifths,
                      );
                      controller.selectedTime.value =
                          "${datetime!.hour.toString().padLeft(2, "0")}:${datetime!.minute.toString().padLeft(2, "0")}";
                      controller.timeSelected.value = true;
                    },
                    child: Obx(() {
                      return Text(
                        controller.selectedTime.value,
                        style: const TextStyle(color: Colors.white),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Крепкость табака:",
                  style: TextStyle(color: Colors.white),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.tabacoScore.value,
                    icon: const Icon(Icons.arrow_downward),
                    dropdownColor: Colors.black38,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String? value) {
                      controller.tabacoScore.value = value!;
                    },
                    items: ["Легкий", "Средний", "Крепкий"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Вкус табака:",
                  style: TextStyle(color: Colors.white),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.tabacoTasty.value,
                    icon: const Icon(Icons.arrow_downward),
                    dropdownColor: Colors.black38,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String? value) {
                      controller.tabacoTasty.value = value!;
                    },
                    items: [
                      "Цитрус",
                      "Сладкий",
                      "Ягодный",
                      "Пряный",
                      "Фрукты",
                      "Десерт"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
            SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: controller.commentController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Комментарий',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                )),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: Obx(() {
                return TextButton(
                  onPressed: !controller.timeSelected.value
                      ? null
                      : () {
                          try {
                            controller.postOrder();
                            Get.back();
                            Get.dialog(successOrder());
                          } catch (e) {
                            print(e);
                          }
                        },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Color.fromRGBO(39, 129, 129, 1),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Подтвердить заказ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Color.fromRGBO(39, 129, 129, 1),
                      ),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Отменить заказ",
                    style: TextStyle(color: Color.fromRGBO(39, 129, 129, 1)),
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

AlertDialog authDialog() {
  return AlertDialog(
    alignment: Alignment.topRight,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: controller.phoneController,
          inputFormatters: [formatter],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Введите телефон",
            fillColor: Colors.white70,
          ),
        ),
        const Divider(),
        TextField(
          controller: controller.passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Введите пароль",
            fillColor: Colors.white70,
          ),
        ),
        const Divider(),
        Obx(
          () => Visibility(
            visible: controller.visiblyErr.value,
            child: const Text(
              "Некорректный логин/пароль",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () async {
              var resp = await controller.postAuth();
              resp ? Get.back() : controller.visiblyErr.value = true;
              Future.delayed(const Duration(seconds: 3))
                  .then((value) => controller.visiblyErr.value = false);
            },
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(
                Color.fromRGBO(39, 129, 129, 1),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Вход",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

AlertDialog registerDialog() {
  return AlertDialog(
    alignment: Alignment.topRight,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // TextField(
        //   controller: controller.nameController,
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     filled: true,
        //     hintStyle: TextStyle(color: Colors.grey[800]),
        //     hintText: "Введите имя",
        //     fillColor: Colors.white70,
        //   ),
        // ),
        // const Divider(),
        TextField(
          controller: controller.phoneController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            formatter,
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Введите телефон",
            fillColor: Colors.white70,
          ),
        ),
        const Divider(),
        TextField(
          controller: controller.passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Введите пароль",
            fillColor: Colors.white70,
          ),
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: controller.postRegistration,
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(
                Color.fromRGBO(39, 129, 129, 1),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Отправить",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const Divider(),
        Obx(
              () => Visibility(
            visible: controller.visiblyErr.value,
            child: const Text(
              "Пользователь уже существует",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    ),
  );
}
