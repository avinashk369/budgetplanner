import 'package:budgetplanner/utils/category_constants.dart';
import 'package:flutter/material.dart';

class ImageData {
  final String name;
  final IconData iconName;
  final Color colorName;

  ImageData(this.name, this.iconName, this.colorName);
  static List<ImageData> getBudgetCategoryImageList() {
    List<ImageData> iconList = [
      ImageData(travel, Icons.travel_explore, Color(0xff52b2cf)),
      ImageData(foodNDrink, Icons.emoji_food_beverage, Color(0xffe76f51)),
      ImageData(shopping, Icons.shopping_bag, Color(0xffffcb77)),
      ImageData(transport, Icons.emoji_transportation, Color(0xff2176ff)),
      ImageData(home, Icons.home, Color(0xff00a8e8)),
      ImageData(billNFee, Icons.receipt, Color(0xffff0054)),
      ImageData(entertainment, Icons.music_note, Color(0xffdc0073)),
      ImageData(carNMotors, Icons.car_rental, Color(0xff7b9e89)),
      ImageData(personal, Icons.person, Color(0xffe9b44c)),
      ImageData(healthcare, Icons.health_and_safety, Color(0xffcc444b)),
      ImageData(education, Icons.cast_for_education, Color(0xffe9b44c)),
      ImageData(groceries, Icons.local_grocery_store, Color(0xff89fc00)),
      ImageData(gift, Icons.card_giftcard, Color(0xfff5b700)),
      ImageData(sports, Icons.sports, Color(0xff245501)),
      ImageData(beauty, Icons.face_rounded, Color(0xffc08497)),
      ImageData(business, Icons.business, Color(0xff3bceac)),
      ImageData(others, Icons.no_accounts, Color(0xff43281c)),
    ];
    return iconList;
  }

  static List<ImageData> getIncomeCategoryImageList() {
    List<ImageData> iconList = [
      ImageData(salary, Icons.money, Color(0xffd3ab9e)),
      ImageData(business, Icons.business, Color(0xff0d0c1d)),
      ImageData(gift, Icons.card_giftcard, Color(0xff9b2915)),
      ImageData(extraIncome, Icons.attach_money_rounded, Color(0xff748cab)),
      ImageData(loan, Icons.trending_down, Color(0xff074f57)),
      ImageData(insurancePayout, Icons.payment, Color(0xff243119)),
      ImageData(others, Icons.no_accounts, Color(0xff43281c)),
    ];
    return iconList;
  }

  static List<ImageData> getSavingCategoryImageList() {
    List<ImageData> iconList = [
      ImageData(brokerage, Icons.money_off, Colors.redAccent),
      ImageData(retirement, Icons.chair, Colors.lightGreen),
      ImageData(health, Icons.health_and_safety, Colors.red),
      ImageData(education, Icons.cast_for_education, Colors.blueGrey),
      ImageData(vacation, Icons.holiday_village, Colors.lightGreen),
      ImageData(wedding, Icons.ring_volume, Colors.pink),
      ImageData(emergencyFund, Icons.alarm, Colors.redAccent),
      ImageData(others, Icons.no_accounts, Colors.lightGreen),
    ];
    return iconList;
  }
}
