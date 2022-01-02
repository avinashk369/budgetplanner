import 'dart:convert';
import 'dart:math';

import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/CaffairModel.dart';
import 'package:budgetplanner/models/notification_model.dart';
import 'package:budgetplanner/models/notification_type.dart';
import 'package:budgetplanner/models/promotion_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

const CURVE_HEIGHT = 160.0;
const AVATAR_RADIUS = CURVE_HEIGHT * 0.28;
const AVATAR_DIAMETER = AVATAR_RADIUS * 2;

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
      body: gridTab(),
    );
  }

  Widget gridTab() => GridView.builder(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  child: Icon(dataRepositoryImpl.iconUrl(travel)!.iconName),
                  onPressed: () {
                    action(actions[index]);
                  },
                ),
              ),
              Text(
                actions[index],
                style: kLabelStyleBold.copyWith(color: kWhite),
              ),
            ],
          ),
        );
      });

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
          '{"title": "Merry Christmas", "img_url": "https://image.freepik.com/free-vector/hand-drawn-flat-secret-santa-illustration_23-2149154977.jpg", "src_url":"https://image.freepik.com/free-vector/hand-drawn-flat-secret-santa-illustration_23-2149154977.jpg",  "sq":0}',
          // '{"title": "Sick Of Having No Money? Do These 10 Things!", "img_url": "https://bethebudget.com/wp-content/uploads/2020/05/Sick-Of-Having-No-Money.jpg", "src_url":"https://bethebudget.com/sick-of-having-no-money/",  "sq":3}',
          // '{"title": "10 Ways To Stop Spending Money When You’re Bored", "img_url": "https://bethebudget.com/wp-content/uploads/2020/08/Stop-Spending-When-Bored.jpg", "src_url":"https://bethebudget.com/how-to-stop-spending-money-when-bored/",  "sq":4}',
          // '{"title": "7 tips for improving your financial health", "img_url": "https://mediafeed.org/wp-content/uploads/2020/06/iStock-1086664998.original.jpg", "src_url":"https://mediafeed.org/7-tips-for-improving-your-financial-health/",  "sq":5}',
          // '{"title": "New version available. Please update ", "img_url": "https://image.freepik.com/free-vector/update-concept-illustration_114360-1742.jpg", "src_url":"https://play.google.com/store/apps/details?id=com.finance.budgetplanner",  "sq":0}',
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

  Widget lineShape() => Container(
        width: double.infinity,
        height: CURVE_HEIGHT,
        child: CustomPaint(
          painter: _MyPainter(),
        ),
      );
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Colors.purple[700]!;

    Offset circleCenter = Offset(size.width / 2, size.height - AVATAR_RADIUS);

    Offset topLeft = Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height * 0.25);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height * 0.5);

    Offset leftCurveControlPoint =
        Offset(circleCenter.dx * 0.5, size.height - AVATAR_RADIUS * 1.5);
    Offset rightCurveControlPoint =
        Offset(circleCenter.dx * 1.6, size.height - AVATAR_RADIUS);

    final arcStartAngle = 200 / 180 * pi;
    final avatarLeftPointX =
        circleCenter.dx + AVATAR_RADIUS * cos(arcStartAngle);
    final avatarLeftPointY =
        circleCenter.dy + AVATAR_RADIUS * sin(arcStartAngle);
    Offset avatarLeftPoint =
        Offset(avatarLeftPointX, avatarLeftPointY); // the left point of the arc

    final arcEndAngle = -5 / 180 * pi;
    final avatarRightPointX =
        circleCenter.dx + AVATAR_RADIUS * cos(arcEndAngle);
    final avatarRightPointY =
        circleCenter.dy + AVATAR_RADIUS * sin(arcEndAngle);
    Offset avatarRightPoint = Offset(
        avatarRightPointX, avatarRightPointY); // the right point of the arc

    Path path = Path()
      ..moveTo(topLeft.dx,
          topLeft.dy) // this move isn't required since the start point is (0,0)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy,
          avatarLeftPoint.dx, avatarLeftPoint.dy)
      ..arcToPoint(avatarRightPoint, radius: Radius.circular(AVATAR_RADIUS))
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
          bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
