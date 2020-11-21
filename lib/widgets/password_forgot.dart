import 'package:flutter/material.dart';
import 'package:menu/login.dart';
import 'package:menu/register.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final key = GlobalKey<FormState>();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                            child: Text('Mot de passe oublié ?',style: TextStyle(
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
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (val){
                            if((val.length > 8) | (val.length < 8)){
                              return "le numéro doit être à 8 chiffres ";
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                              icon: Icon(Icons.phone,color: Colors.grey,),
                              hintText: 'Numero de téléphone'
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 50,),

                GestureDetector(
                  onTap: () async{
                      if(key.currentState.validate()){
                        var response = await http.get("http://shapshapmarket.com/api/forgot_password/"+phoneController.text).then((value){
                            Toast.show("Vous allez recevoir un SMS", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Color(0xFFF17532));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginApp()));
                        });
                      }
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
                      child: Text('Envoyer'.toUpperCase() , style: TextStyle(
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
