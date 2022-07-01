import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gettest/db/db_helper.dart';
import 'package:gettest/services/theme_services.dart';
import 'package:gettest/ui/home_page.dart';
import 'package:gettest/ui/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter TodoApp',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeServices().theme,
      darkTheme: Themes.dark,
      theme: Themes.light,
    
      home: HomePage()
    );
  }
}





