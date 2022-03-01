// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:the_user_login/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Box? box1;
  @override
  void initState() {
    super.initState();
    OpenBox();

  }

  void OpenBox() async{
    box1 = await Hive.openBox('logindata');
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //show signed in user data
              Text('Name: ${box1?.get('WelPage_name')}'),
              Text('Email:  ${box1?.get('WelPage_email')}'),
              Text('Phone No:  ${box1?.get('WelPage_phone')}'),

              //logged out delete all the data from hive db
              ElevatedButton(onPressed: (){
                box1?.put('isLogged',false);
                box1?.delete('WelPage_name');
                box1?.delete('WelPage_email');
                box1?.delete('WelPage_phone');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const Login_Page()));
              }, child: const Text('LogOut'))
            ],
          ),
        )
    );
  }
}