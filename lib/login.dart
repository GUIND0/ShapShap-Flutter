import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu/register.dart';
import 'package:menu/widgets/password_forgot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'package:toast/toast.dart';
import 'helper/functions.dart';
import 'main.dart';

void main() => runApp(LoginApp());

TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  String emailError = "";
  String passwordError = "";



  final key = GlobalKey<FormState>();

  signIn(String email, String password) async{

    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)){
      if(passwordController.text.length > 3){

        setState(() {
          _isLoading = true;
        });



        Map data = {
          "email": email,
          "password": password
        };
        var jsonData = null;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        var response = await http.post("http://shapshapmarket.com/auth/token/login/",body:data);
        if(response.statusCode == 200){
          String source = Utf8Decoder().convert(response.bodyBytes);
          jsonData = json.decode(source);
          sharedPreferences.setString("token", jsonData['auth_token']);


          var response2 = await http.get("http://shapshapmarket.com/auth/users/me/",headers: {"Authorization": "Token "+jsonData['auth_token']});
          if(response2.statusCode == 200){
            String source1 = Utf8Decoder().convert(response2.bodyBytes);
            var jsonData2 = json.decode(source1);
            print(response2.body.toString());

            sharedPreferences.setString("id", jsonData2['id'].toString()).then((value){
              sharedPreferences.setString("first_name", jsonData2['first_name'].toString()).then((value){
                sharedPreferences.setString("last_name", jsonData2['last_name'].toString()).then((value){
                  sharedPreferences.setString("phone", jsonData2['phone'].toString()).then((value){
                    sharedPreferences.setString("email", jsonData2['email'].toString()).then((value){
                      sharedPreferences.setString("email", jsonData2['email'].toString()).then((value){
                        sharedPreferences.setString("types", jsonData2['types'].toString()).then((value){

                          sharedPreferences.setString("password", passwordController.text);
                          Function.id = jsonData2['id'].toString();
                          Function.email = jsonData2['email'].toString();
                          Function.first_name = jsonData2['first_name'].toString();
                          Function.last_name = jsonData2['last_name'].toString();
                          Function.types = jsonData2['types'].toString();
                          Function.phone = jsonData2['phone'].toString();
                          Function.password = passwordController.text;

                          setState(() {
                            _isLoading = false;

                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => App()
                            ));
                          });

                        });

                      });
                    });
                  });
                });
              });
            });
          }else{
            setState(() {
              _isLoading = false;

            });
            Toast.show("Indentifiants incorrectes", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));

            var jsonData2 = json.decode(response2.body);
            print(jsonData2.toString());
          }
        }else{
          print(response.body);
          setState(() {
            _isLoading = false;

          });
          Toast.show("Indentifiants incorrectes", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));

        }




      }else{
        Toast.show("le mot de passe doit être superieur à 3 caractères ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));
      }

    }else{
      Toast.show("Email invalide", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));

    }



  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator(backgroundColor: Color(0xFFf45d27),),):Container(
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFf45d27),
                        Color(0xFFf5851f)
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90)
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.person,size: 90,color: Colors.white,),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: (){
                            // nothing here it was a mistake
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 32,bottom: 32),
                            child: Text('Se connecter',style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                            ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 32),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: 50,
                        padding: EdgeInsets.only(top: 4,left: 16,right: 16,bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: TextFormField(
                          validator: (val){


                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                            icon: Icon(Icons.email,color: Colors.grey,),
                            hintText: 'Email'
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top: 42),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: 50,
                        padding: EdgeInsets.only(top: 4,left: 16,right: 16,bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5
                              )
                            ]
                        ),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.vpn_key,color: Colors.grey,),
                              hintText: 'Mot de passe'
                          ),
                        ),
                      )
                    ],
                  ),
                ),


                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Forgot()));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16,right: 32),
                      child: Text(
                          "Mot de passe oublié",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ),
                ),



                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterApp()));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16,right: 32),
                      child: Text(
                        "Besoin d'un Compte ?",
                        style: TextStyle(
                            color: Color(0xFFf45d27),
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50,),

                GestureDetector(
                  onTap: (){

                    signIn(emailController.text,passwordController.text);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/1.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFf45d27),
                          Color(0xFFf5851f)
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Center(
                      child: Text('Se connecter'.toUpperCase() , style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}
