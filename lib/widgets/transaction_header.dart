import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_constants.dart';

class TransactionHeader extends StatelessWidget {
  final String imageUrl;

  const TransactionHeader({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: Get.height * .25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: kWhite,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
