import 'package:http/http.dart' as http ;
import 'package:flutter/material.dart';
import 'package:menu/helper/functions.dart';
import 'package:menu/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {

  final formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  change() async{
    if(formKey.currentState.validate()){
      var response = await http.get("http://shapshapmarket.com/api/users/password/"+Function.id+"/"+ newPasswordController.text.trim());
      Function.password = newPasswordController.text.trim();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("password", newPasswordController.text.trim()).then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => LoginApp()
        ));
      });
    }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFFF17532),
        centerTitle: true,
        title: Text("Changer votre mot de passe",style: TextStyle(color: Colors.white),),
      ),
      body: Container(

        padding: EdgeInsets.symmetric(vertical: 24,horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                controller: passwordController,
                // ignore: missing_return
                validator: (val){

                  if(val.trim() != Function.password){
                    return "Entrez l'ancien mot de passe";
                  }
                  if(val.length < 6){
                    return "longueur incorrecte";
                  }

                  return null;

                },

                decoration: InputDecoration(
                  hintText: "Ancien mot de passe",
                  icon: Icon(Icons.lock,color: Colors.grey,),
                ),
              ),
              TextFormField(
                obscureText: true,
                // ignore: missing_return
                validator: (val){
                      if(val.length < 6){
                        return "longueur incorrecte";
                      }
                      if(val != confirmPasswordController.text.trim()){
                        return "pas match";
                      }
                      return null;
                  },
                controller: newPasswordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Nouveau mot de passe",
                  icon: Icon(Icons.lock,color: Colors.grey,),
                ),
              ),

              TextFormField(
                obscureText: true,
                validator: (val){
                  if(val.trim() != newPasswordController.text.trim()){
                    return "pas match";
                  }
                  if(val.length < 6){
                    return "longueur incorrecte";
                  }
                  return null;
                },
                controller: confirmPasswordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Confirmer",
                  icon: Icon(Icons.lock,color: Colors.grey,),
                ),
              ),

              SizedBox(height: 20,),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                child: Text("Valider",style: TextStyle(color: Colors.white),),
                onPressed: (){
                  change();
                },
                color: Color(0xFFF17532),
              )
            ],
          ),
        ),
      ),
    );
  }
}
