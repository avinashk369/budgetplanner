import 'dart:convert';

import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/CaffairModel.dart';
import 'package:budgetplanner/models/notification_model.dart';
import 'package:budgetplanner/models/notification_type.dart';
import 'package:budgetplanner/models/promotion_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class FireCrud extends StatefulWidget {
  const FireCrud({Key? key}) : super(key: key);

  @override
  _FireCrudState createState() => _FireCrudState();
}

class _FireCrudState extends State<FireCrud> {
  List<String> actions = [
    'create',
    'update',
    'read',
    'delete',
    'notification',
    'promotion'
  ];
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  DataRepositoryImpl dataRepositoryImpl = DataRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: kDarkGrey,
              ),
              child: Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      child: Icon(dataRepositoryImpl.iconUrl(travel)!.iconName),
                      onPressed: () {
                        action(actions[index]);
                      },
                    ),
                  ),
                  Text(actions[index]),
                ],
              ),
            );
          }),
    );
  }

  void action(String name) async {
    switch (name) {
      case "create":
        await dataRepositoryImpl.createBudgetCategory();
        await dataRepositoryImpl.createExpenseType();
        await dataRepositoryImpl.createIncomeCategory();
        await dataRepositoryImpl.createRecurrenceType();
        await dataRepositoryImpl.createSavingCategory();
        await dataRepositoryImpl.createTransactionType();
        await dataRepositoryImpl.createExpenseSource();
        break;
      case "read":
        BaseModel<CaffairModel> records =
            await userRepositoryImpl.readCollections();
        //print(records.data!.title);
        break;
      case "update":
        dataRepositoryImpl.iconUrl('health');
        break;
      case "delete":
        await dataRepositoryImpl.clear(budgetCategory);
        await dataRepositoryImpl.clear(incomeCategory);
        await dataRepositoryImpl.clear(expenseType);
        await dataRepositoryImpl.clear(recurranceCategory);
        await dataRepositoryImpl.clear(transactionType);
        await dataRepositoryImpl.clear(savingCategory);
        await dataRepositoryImpl.clear(expenseSource);
        break;
      case "notification":
        NotificationModel notificationModel = NotificationModel();
        notificationModel.title = "";
        notificationModel.desc = "";
        notificationModel.isEvening = true;
        notificationModel.notificationType =
            NotificationType.Reminder.toString();
//{id: null, title: , desc: , type: NotificationType.Reminder, img_url: null, has_img: false, is_mrng: false, is_evng: true, is_hrly: false}
        List<String> notifications = [
          '{"title": " 💰 Much or Less 💰 ", "desc": "Record every transaction 🎯 ", "type":  "Reminder","is_mrng":true}',
          '{"title": " Day has past 🌙 ", "desc": "Have you recorded your transaction today? 🏁 ", "type":  "Reminder","is_evng":true}',
          '{"title": " Money saving challenge ", "desc": "Save minimum 1000 this month 🎯 ", "type":  "Challenge"}',
          '{"title": " Track your money 💸 ", "desc": "Don\'t let go your money unnoticed ", "type":  "Promotional"}',
        ];
        notifications.forEach((element) {
          notificationModel = NotificationModel.fromJson(jsonDecode(element));
          print(notificationModel.title.toString());
          dataRepositoryImpl.createNotifications(notificationModel);
        });

        break;
      case "promotion":
        List<String> promotions = [
          '{"title": " More you record more you save ", "img_url": "https://miro.medium.com/max/2000/1*clLHov-e8fX12CZr4zpKIg.png ", "src_url":"https://medium.com/flutterdevs/stepper-widget-in-flutter-37ce5b45575b",  "sq":1}',
          '{"title": " Spend only when you have ", "img_url": "https://miro.medium.com/max/2000/1*clLHov-e8fX12CZr4zpKIg.png", "src_url":"https://medium.com/flutterdevs/stepper-widget-in-flutter-37ce5b45575b",  "sq":2}',
          '{"title": " Investing is the new savings ", "img_url": "https://miro.medium.com/max/2000/1*clLHov-e8fX12CZr4zpKIg.png", "src_url":"https://medium.com/flutterdevs/stepper-widget-in-flutter-37ce5b45575b",  "sq":3}',
          '{"title": " Budget planning is key of a financial freedom ", "img_url": "https://miro.medium.com/max/2000/1*clLHov-e8fX12CZr4zpKIg.png", "src_url":"https://medium.com/flutterdevs/stepper-widget-in-flutter-37ce5b45575b",  "sq":4}',
          '{"title": " Be wise while investing", "img_url": "https://miro.medium.com/max/2000/1*clLHov-e8fX12CZr4zpKIg.png", "src_url":"https://medium.com/flutterdevs/stepper-widget-in-flutter-37ce5b45575b",  "sq":5}',
        ];
        promotions.forEach((element) {
          PromotionModel promotionModel =
              PromotionModel.fromJson(jsonDecode(element));
          print(promotionModel.title.toString());
          dataRepositoryImpl.creatPromotions(promotionModel);
        });
        break;
    }
  }
}
