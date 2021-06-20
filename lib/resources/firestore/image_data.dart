import 'package:budgetplanner/utils/category_constants.dart';
import 'package:flutter/material.dart';

class ImageData {
  final String name;
  final IconData iconName;

  ImageData(this.name, this.iconName);
  static List<ImageData> getBudgetCategoryImageList() {
    List<ImageData> iconList = [
      ImageData(travel, Icons.travel_explore),
      ImageData(foodNDrink, Icons.emoji_food_beverage),
      ImageData(shopping, Icons.shopping_bag),
      ImageData(transport, Icons.emoji_transportation),
      ImageData(home, Icons.home),
      ImageData(billNFee, Icons.receipt),
      ImageData(entertainment, Icons.music_note),
      ImageData(carNMotors, Icons.car_rental),
      ImageData(personal, Icons.person),
      ImageData(healthcare, Icons.health_and_safety),
      ImageData(education, Icons.cast_for_education),
      ImageData(groceries, Icons.local_grocery_store),
      ImageData(gift, Icons.card_giftcard),
      ImageData(sports, Icons.sports),
      ImageData(beauty, Icons.face_rounded),
      ImageData(business, Icons.business),
      ImageData(others, Icons.no_accounts),
    ];
    return iconList;
  }

  static List<ImageData> getIncomeCategoryImageList() {
    List<ImageData> iconList = [
      ImageData(salary, Icons.money),
      ImageData(business, Icons.business),
      ImageData(gift, Icons.card_giftcard),
      ImageData(extraIncome, Icons.attach_money_rounded),
      ImageData(loan, Icons.trending_down),
      ImageData(insurancePayout, Icons.payment),
      ImageData(others, Icons.no_accounts),
    ];
    return iconList;
  }

  static List<ImageData> getSavingCategoryImageList() {
    List<ImageData> iconList = [
      ImageData(brokerage, Icons.money_off),
      ImageData(retirement, Icons.chair),
      ImageData(health, Icons.health_and_safety),
      ImageData(education, Icons.cast_for_education),
      ImageData(vacation, Icons.holiday_village),
      ImageData(wedding, Icons.ring_volume),
      ImageData(emergencyFund, Icons.alarm),
      ImageData(others, Icons.no_accounts),
    ];
    return iconList;
  }
}
