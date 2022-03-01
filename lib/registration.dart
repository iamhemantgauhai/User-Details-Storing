// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_user_login/login_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class registrationpage extends StatefulWidget {
  const registrationpage({Key? key}) : super(key: key);

  @override
  _registrationpageState createState() => _registrationpageState();
}

class _registrationpageState extends State<registrationpage> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.jpeg"),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,40 , 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset("images/background.jpeg")),
                      const HeightBox(10),
                      "Registration".text.color(Colors.white).size(20).make(),
                      const HeightBox(
                          20
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: _name,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue
                                )
                            ),
                            isDense: true,                      // Added this
                            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const HeightBox(
                          20
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue
                                )
                            ),
                            isDense: true,                      // Added this
                            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const HeightBox(
                          20
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: _phone,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue
                                )
                            ),
                            isDense: true,                      // Added this
                            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const HeightBox(
                          20
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          obscureText: true,
                          controller: _pass,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.white
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue
                                )
                            ),
                            isDense: true,                      // Added this
                            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const HeightBox(20),
                      GestureDetector(
                          onTap:(){
                            Registration();
                          },
                          child: "Sign-Up".text.white.light.xl.makeCentered().box.white.shadowOutline(outlineColor: Colors.grey).color(const Color(0XFFFF0772)).roundedLg.make().w(150).h(40)),
                      const HeightBox(140),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Login_Page()));
          },
          child: RichText(text: const TextSpan(
            text: 'New User?',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: ' Login Now',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0XFF4321F5)),
              ),
            ],
          )
          ).pLTRB(20, 0, 0, 15),
        )
    );
  }
  Future Registration() async{
    var regAPIUrl = "https://protocoderspoint.com/php/registration.php";

    Map maped = {
      'name':_name.text,
      'email':_email.text,
      'phone': _phone.text,
      'password':_pass.text
    };

    http.Response response = await http.post(Uri.parse(regAPIUrl),body: maped);

    var data = jsonDecode(response.body);

    print("Data: $data");
  }
}