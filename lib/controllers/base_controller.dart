import 'dart:math';

import 'package:budgetplanner/resources/firestore/image_data.dart';
import 'package:budgetplanner/widgets/_ModalBottomSheetLayout.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void modalBottomSheetMenu(
      BuildContext context, List<ImageData> imageList, Function iconClicked) {
    Random random = new Random();
    showModalBottomSheetApp(
        dismissOnTap: true,
        context: context,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 30 / 27,
                    ),
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: imageList[index].colorName,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                imageList[index].iconName,
                                size: 35,
                                color: whiteColor,
                              ),
                              onPressed: () {
                                //Navigator.of(context).pop();
                                iconClicked(imageList[index].name);
                              },
                            ),
                          ),
                          Text(
                            imageList[index].name,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          );
        },
        statusBarHeight: Get.height * .5);
  }
}
