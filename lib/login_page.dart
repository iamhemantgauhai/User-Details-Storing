// ignore_for_file: camel_case_types, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:the_user_login/registration.dart';
import 'package:the_user_login/welcome.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  bool isChecked = false;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  late Box box1;

  @override
  void initState() {
    super.initState();
    createBox();

  }

  void createBox()async{
    box1 = await Hive.openBox('logindata');
    getdata();
  }
  void getdata()async{

    if(box1.get('email')!=null){
      email.text = box1.get('email');
      isChecked = true;
      setState(() {

      });
    }
    if(box1.get('pass')!=null){
      pass.text = box1.get('pass');
      isChecked = true;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.jpeg"),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset("images/background.jpeg")),
                    const HeightBox(10),
                    "Login".text.color(Colors.white).size(20).make(),
                    const HeightBox(20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.blue)),
                          isDense: true,
                          contentPadding:
                          const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        ),
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const HeightBox(20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextField(
                        controller: pass,
                        obscureText:true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.blue)),
                          isDense: true,
                          // Added this
                          contentPadding:
                          const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        ),
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Remember Me",style: TextStyle(color: Colors.white),),
                        Checkbox(
                          value: isChecked,
                          onChanged: (value){
                            isChecked = !isChecked;
                            setState(() {

                            });
                          },
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Forgot Password ? Reset Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const HeightBox(10),
                    GestureDetector(
                        onTap: () {
                          print("Login Clicked Event");
                          login();
                        },
                        child: "Login".text.white.light.xl.makeCentered().box.white.shadowOutline(outlineColor: Colors.grey).color(const Color(0XFFFF0772)).roundedLg.make().w(150).h(40)),
                    const HeightBox(20),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const registrationpage()));
          },
          child: RichText(
              text: const TextSpan(
                text: 'New User?',
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Register Now',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0XFF4321F5)),
                  ),
                ],
              )).pLTRB(20, 0, 0, 15),
        ));
  }


  void login() async {
    var regAPIUrl = "https://protocoderspoint.com/php/login.php";

    Map maped = {
      'email':email.text,
      'password':pass.text,

    };

    http.Response response = await http.post(Uri.parse(regAPIUrl),body: maped);

    var data = jsonDecode(response.body);
    if(data['success']=='1'){
      if(isChecked){
        box1.put('email', email.value.text);
        box1.put('pass', pass.value.text);
      }
      box1.put('WelPage_name', data['name']);
      box1.put('WelPage_email', data['email']);
      box1.put('WelPage_phone', data['phone']);
      box1.put('isLogged',true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>const WelcomePage()));
    }
  }
}