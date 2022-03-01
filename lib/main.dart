import 'package:flutter/material.dart';
import 'package:the_user_login/welcome.dart';
import 'login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
late Box box1;

//init hive db and open the HIVE box
void main()  async{
  await Hive.initFlutter();
  box1 = await Hive.openBox('logindata');//init hive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: box1.get('isLogged',defaultValue: false)?const WelcomePage():const Login_Page()  // load login page
    );
  }
}