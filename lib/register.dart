import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'package:toast/toast.dart';
import 'login.dart';
import 'main.dart';


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

TextEditingController firstController = new TextEditingController();
TextEditingController emailController = new TextEditingController();
TextEditingController lastController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
TextEditingController passwordConfirmeController = new TextEditingController();
TextEditingController PhoneController = new TextEditingController();
TextEditingController userController = new TextEditingController();
String tag = "Client";

class RegisterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  bool _hasError = false;

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
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4,
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
                            child: Text('Créer un compte',style: TextStyle(
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
                        child: TextField(
                          controller: firstController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.person,color: Colors.grey,),
                              hintText: 'Prenom'
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
                        height:  50,
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

                          controller: lastController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.person_outline,color: Colors.grey,),
                              hintText: 'Nom'
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
                        child: TextField(
                          controller: userController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.person,color: Colors.grey,),
                              hintText: 'Pseudo/Nom de la boutique'
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
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (String value){

                          },
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
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: PhoneController,

                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.phone,color: Colors.grey,),
                              hintText: 'Tél'
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
                          controller: passwordConfirmeController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.vpn_key,color: Colors.grey,),
                              hintText: 'Confirmer ...'
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 30,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),

                  child: new DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(tag),

                    items: <String>['Vendeur', 'Client'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {

                      setState(() {
                        tag = _.toLowerCase();
                      });


                    },
                  ),
                ),

                SizedBox(height: 50,),

                GestureDetector(
                  onTap: (){
                    signup();
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

                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),

    );
  }


  void signup() async {
    if (userController.text.length > 3) {
      if (firstController.text.length > 3) {
        if (lastController.text.length > 1) {
          if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(emailController.text)) {
            if (PhoneController.text.length == 8) {
              if (passwordController.text.length > 5) {
                if (passwordController.text == passwordController.text) {
                  setState(() {
                    _isLoading = true;
                  });

                  Map data = {
                    "email": emailController.text,
                    "first_name": firstController.text,
                    "last_name": lastController.text,
                    "phone": PhoneController.text,
                    "types": tag,
                    "password": passwordController.text,
                    "username": userController.text
                  };

                  var jsonData = null;
                  SharedPreferences sharedPreferences = await SharedPreferences
                      .getInstance();
                  var response = await http.post(
                      "http://shapshapmarket.com/auth/users/",
                      body: data);
                  if (response.statusCode == 201) {
                    jsonData = json.decode(response.body);
                    setState(() {
                      _isLoading = false;
                      sharedPreferences.setString(
                          "first_name", jsonData['first_name']);
                      sharedPreferences.setString(
                          "last_name", jsonData['last_name']);
                      sharedPreferences.setString("phone", jsonData['phone']);
                      sharedPreferences.setString("email", jsonData['email']);

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginApp()), (
                          Route<dynamic>route) => false);
                    });
                  } else {
                    print(response.body);
                    setState(() {
                      _isLoading = false;
                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => App()),(Route<dynamic>route) => false);
                    });

                    Toast.show(
                        "Ce compte existe déja.Réessayez avec d'autres informations.",
                        context, duration: Toast.LENGTH_LONG,
                        gravity: Toast.CENTER,
                        backgroundColor: Color(0xFFF17532));
                  }
                } else {
                  // confirm
                  Toast.show(
                      "Pas de correspondance entre le mot de passe et la confirmation",
                      context, duration: Toast.LENGTH_LONG,
                      gravity: Toast.CENTER,
                      backgroundColor: Color(0xFFF17532));
                }
              } else {
                //  password
                Toast.show("Le mot de passe doit être superieur à 3 caractères",
                    context, duration: Toast.LENGTH_LONG,
                    gravity: Toast.CENTER,
                    backgroundColor: Color(0xFFF17532));
              }
            } else {
              //phone

              Toast.show("Le numéro de téléphone n'est pas valide", context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.CENTER,
                  backgroundColor: Color(0xFFF17532));
            }
          } else {
            //email
            Toast.show(
                "Adresse email invalide", context, duration: Toast.LENGTH_LONG,
                gravity: Toast.CENTER,
                backgroundColor: Color(0xFFF17532));
          }
        } else {
          //nom
          Toast.show("Nom doit être superieur à 1 caractère ", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Color(0xFFF17532));
        }
      } else {
        //prenom

        Toast.show("Prénom doit être superieur à 3 caractères ", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Color(0xFFF17532));
      }
    }else{

      Toast.show("Pseudo/Boutique doit être superieur à 3 caractères ", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Color(0xFFF17532));
    }
  }

}


