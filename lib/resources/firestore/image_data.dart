import 'package:budgetplanner/utils/category_constants.dart';
import 'package:flutter/material.dart';

class ImageData {
  final String name;
  final IconData iconName;
  final Color colorName;

  ImageData(this.name, this.iconName, this.colorName);
  static List<ImageData> getBudgetCategoryImageList() {
    List<ImageData> iconList = [
      ImageData(travel, Icons.travel_explore, Colors.teal.shade300),
      ImageData(
          foodNDrink, Icons.emoji_food_beverage, Colors.deepOrange.shade400),
      ImageData(shopping, Icons.shopping_bag, Colors.blueAccent.shade200),
      ImageData(transport, Icons.emoji_transportation, Colors.lightGreen),
      ImageData(home, Icons.home, Colors.amberAccent.shade400),
      ImageData(billNFee, Icons.receipt, Colors.red.shade200),
      ImageData(entertainment, Icons.music_note, Colors.pink.shade200),
      ImageData(carNMotors, Icons.car_rental, Colors.cyan),
      ImageData(personal, Icons.person, Colors.brown),
      ImageData(healthcare, Icons.health_and_safety, Colors.redAccent),
      ImageData(education, Icons.cast_for_education, Colors.blue),
      ImageData(groceries, Icons.local_grocery_store, Colors.green),
      ImageData(gift, Icons.card_giftcard, Colors.lightGreen),
      ImageData(sports, Icons.sports, Colors.pinkAccent),
      ImageData(beauty, Icons.face_rounded, Colors.brown.shade400),
      ImageData(business, Icons.business, Colors.blueGrey),
      ImageData(others, Icons.no_accounts, Colors.grey),
    ];
    return iconList;
  }

  static List<ImageData> getIncomeCategoryImageList() {
    List<ImageData> iconList = [
      ImageData(salary, Icons.money, Colors.blueGrey),
      ImageData(business, Icons.business, Colors.blueGrey.shade300),
      ImageData(gift, Icons.card_giftcard, Colors.lightGreen),
      ImageData(extraIncome, Icons.attach_money_rounded, Colors.redAccent),
      ImageData(loan, Icons.trending_down, Colors.red),
      ImageData(insurancePayout, Icons.payment, Colors.redAccent.shade100),
      ImageData(others, Icons.no_accounts, Colors.lightGreen),
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
