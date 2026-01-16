import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodking_admin/app/data/model/body/notification_body.dart';
import 'package:foodking_admin/app/modules/splash/views/splash_view.dart';
import 'package:foodking_admin/helper/notification_helper.dart';
import 'package:foodking_admin/translation/language.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
dynamic langValue;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  final box = GetStorage();

  langValue = const Locale('en', null);

  if (box.read('languageCode') != null) {
    langValue = Locale(box.read('languageCode'), null);
  } else {
    langValue = const Locale('en', null);
    box.write('languageCode', 'en');
  }

  // ignore: unused_local_variable
  NotificationBody? body;
  try {
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      body = NotificationHelper.convertNotification(remoteMessage.data);
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  } catch (e) {
    debugPrint(e.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder:
          ((context, child) => GetMaterialApp(
            translations: Languages(),
            locale: langValue,
            theme: ThemeData(useMaterial3: false),
            title: 'Yummeals Merchant',
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
          )),
    );
  }
}
