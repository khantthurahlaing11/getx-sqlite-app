
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:gettest/ui/notified_page.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


import '../models/task.dart';

class NotifyHelper{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    tz.initializeTimeZones();
  
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onSelectNotification: selectNotification);
  }


  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    Get.to(()=>NotifiedPage(label: payload));
}

    displayNotification({required String title, required String body}) async {

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
    0, title, body, platformChannelSpecifics,
    payload: 'item x');
  }

    scheduledNotification(int hour,int minutes,Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
    task.id!.toInt(),
    task.title,
    task.note,
    // _convertTime(hour,minutes),
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
    const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description')),
    androidAllowWhileIdle: true,
    payload: "${task.title}|"+"${task.note}|",
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
      
   
   }

   tz.TZDateTime _convertTime(int hour,int minutes){
     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
     tz.TZDateTime scheduleDate = tz.TZDateTime(
       tz.local,now.year,now.month,now.day,hour,minutes
     );
     if(scheduleDate.isBefore(now)){
       scheduleDate = scheduleDate.add(const Duration(days: 1));
     }
     return scheduleDate;
   }

  

}

  