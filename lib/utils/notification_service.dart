import 'dart:convert';
import 'dart:io';

import 'package:budgetplanner/models/notification_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  late List<NotificationModel> notificationModelList;
  Map<String, dynamic> result = {
    'title': "Alert",
    'desc': "Have you recorded your expense today? ",
  };
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  _requestIOSPermission() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }

  /// Streams are created so that app can respond to notification-related events
  /// since the plugin is initialised in the `main` function
  // final BehaviorSubject<ReceivedNotification>
  //     didReceiveLocalNotificationSubject =
  //     BehaviorSubject<ReceivedNotification>();

  // final BehaviorSubject<String?> selectNotificationSubject =
  //     BehaviorSubject<String?>();

  Future<void> init() async {
    if (Platform.isIOS) {
      await _requestIOSPermission();
    }
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/logo');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
    // first get all the notifications
    () async {
      notificationModelList = (await getAllNotifications())!;
      // schedule notification
      scheduleNotifications("reminder");
      scheduleNotifications("challenge");
      scheduleNotifications("promotional");
      //await periodicNotification(result);
    }();
  }

  void scheduleNotifications(String name) async {
    switch (name) {
      case "reminder":
        //remind morning
        for (NotificationModel notificationModel in notificationModelList) {
          if (notificationModel.isMorning != null &&
              notificationModel.isMorning!) {
            await scheduleNotification(
                0, notificationModel, _nextInstanceOfNineAM());
          }
        }
        //remind evening
        for (NotificationModel notificationModel in notificationModelList) {
          if (notificationModel.isEvening != null &&
              notificationModel.isEvening!) {
            await scheduleNotification(
                1, notificationModel, _nextInstanceOfSevenPM());
          }
        }
        break;
      case "challenge":
        //remind evenry 5th day
        for (NotificationModel notificationModel in notificationModelList) {
          if (notificationModel.notificationType == challenge) {
            await scheduleNotification(
                2, notificationModel, _nextInstanceOfFifthDay());
            return;
          }
        }
        break;
      case "promotional":
        //remind daily at 11 am
        for (NotificationModel notificationModel in notificationModelList) {
          if (notificationModel.notificationType == promotional) {
            await scheduleNotificationAtEleven(
                notificationModel, _nextInstanceOfElevenAMDay());
            return;
          }
        }

        break;
    }
  }

  /**
   * get all notificaitons
   */
  Future<List<NotificationModel>?> getAllNotifications() async {
    try {
      return await DataRepositoryImpl().getAllNotifications();
    } catch (e) {}
  }

/**
 *  call back function onDidReceiveLocalNotification
 */
  // Future onDidReceiveLocalNotification(
  //     int id, String? title, String? body, String? payload) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(title!),
  //       content: Text(body!),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: Text('Ok'),
  //           onPressed: () async {
  //             Navigator.of(context, rootNavigator: true).pop();
  //             // await Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //     builder: (context) => SecondScreen(payload!),
  //             //   ),
  //             // );
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

/**
 * call back function when notificaiton is tapped
 */
  Future<void> selectNotification(String? json) async {
    final obj = jsonDecode(json!);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      print("error occured");
    }
  }

/**
 * show instant notification
 */
  Future<void> showNotification(Map<String, dynamic> downloadStatus) async {
    String imagePath =
        'https://images.unsplash.com/photo-1622495546323-5dac33dedb01?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80';
    var attachmentPicturePath =
        await _downloadAndSaveFile(imagePath, 'attachment_img.jpg');
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachmentPicturePath),
      contentTitle: '<b>Attached Image</b>',
      htmlFormatContentTitle: true,
      summaryText: 'Test Image',
      htmlFormatSummaryText: true,
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/logo'),
    );
    final android = AndroidNotificationDetails(
      'bigpic',
      'channel name',
      'channel description',
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: bigPictureStyleInformation,
    );
    final iOS = IOSNotificationDetails(
        attachments: [IOSNotificationAttachment(attachmentPicturePath)]);
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess
            ? 'File has been downloaded successfully!'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

/**
 * instance of scheduled time of seven pm
 */
  tz.TZDateTime _nextInstanceOfSevenPM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print("local time $now");
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 19, 30);
    print("scheduled time $scheduledDate");

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /**
 * instance of scheduled time of seven am
 */
  tz.TZDateTime _nextInstanceOfNineAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print("local time $now");
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 9, 30);
    print("scheduled time $scheduledDate");

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /**
 * instance of scheduled date every fifth days
 */
  tz.TZDateTime _nextInstanceOfFifthDay() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print("local time $now");
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 13);
    print("scheduled time $scheduledDate");

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 5));
    }
    return scheduledDate;
  }

  /**
 * instance of scheduled daily eleven
 */
  tz.TZDateTime _nextInstanceOfElevenAMDay() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print("local time $now");
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    print("scheduled time $scheduledDate");

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /**
   * Schedule notification at 9:30AM
   */
  Future<void> scheduleNotification(int notificationId,
      NotificationModel notificationModel, tz.TZDateTime tzDateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        notificationModel.title,
        notificationModel.desc,
        tzDateTime,
        NotificationDetails(
          android: AndroidNotificationDetails(notificationModel.id!,
              notificationModel.notificationType!, notificationModel.title!),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  /**
   * Schedule notification at 9:30AM
   */
  Future<void> scheduleNotificationAtEleven(
      NotificationModel notificationModel, tz.TZDateTime tzDateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        notificationModel.title,
        notificationModel.desc,
        tzDateTime,
        NotificationDetails(
          android: AndroidNotificationDetails(notificationModel.id!,
              notificationModel.notificationType!, notificationModel.title!),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  /**
   * daily at 7 pm
   */
  Future<void> scheduleDailySevenPMNotification(
      NotificationModel notificationModel) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        notificationModel.title,
        notificationModel.desc,
        _nextInstanceOfSevenPM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily_notification_id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  /**
   * show scheduled notification
   */
  Future<void> zonedSchedule(Map<String, dynamic> downloadStatus,
      {required UILocalNotificationDateInterpretation
          uiLocalNotificationDateInterpretation,
      required bool androidAllowWhileIdle,
      String? payload,
      DateTimeComponents? matchDateTimeComponents}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        12345,
        "A Notification From My App",
        "This notification is brought to you by Local Notifcations Package",
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
        const NotificationDetails(
            android: AndroidNotificationDetails("daily_alert", "report_entry",
                "make sure to enter the records")),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  /**
   * show perodically notification
   */
  Future<void> periodicNotification(Map<String, dynamic> downloadStatus) async {
    // periodically notification
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('daily_notification_channel', 'daily_report',
            'daily_report_description');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        downloadStatus['title'],
        downloadStatus['desc'],
        RepeatInterval.daily,
        platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

/**
 * show notification with attachment
 */
  Future<void> showNotificationWithAttachment() async {
    var attachmentPicturePath = await _downloadAndSaveFile(
        'https://via.placeholder.com/800x200', 'attachment_img.jpg');
    var iOSPlatformSpecifics = IOSNotificationDetails(
      attachments: [IOSNotificationAttachment(attachmentPicturePath)],
    );
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachmentPicturePath),
      contentTitle: '<b>Attached Image</b>',
      htmlFormatContentTitle: true,
      summaryText: 'Test Image',
      htmlFormatSummaryText: true,
    );
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL ID 2',
      'CHANNEL NAME 2',
      'CHANNEL DESCRIPTION 2',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    var notificationDetails = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Title with attachment',
      'Body with Attachment',
      notificationDetails,
    );
  }

/**
 * download url image to dir.
 */
  _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  /**
   * get all pending notification
   */
  Future<int> getPendingNotificationCount() async {
    List<PendingNotificationRequest> p =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return p.length;
  }

  /**
   * cancel all notificaiton
   */
  Future<void> cancelNotification() async {
    getPendingNotificationCount().then((value) async {
      if (value > 0) await flutterLocalNotificationsPlugin.cancelAll();
    });
  }
}
