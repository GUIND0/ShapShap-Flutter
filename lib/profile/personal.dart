import 'package:flutter/material.dart';
import 'package:menu/helper/functions.dart';
import 'package:http/http.dart' as http ;
import 'package:menu/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Identifiant extends StatefulWidget {
  @override
  _IdentifiantState createState() => _IdentifiantState();
}

class _IdentifiantState extends State<Identifiant> {

  final formKey = GlobalKey<FormState>();

  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  updateInfo() async{
    if(formKey.currentState.validate()){
      var response = await http.get("http://shapshapmarket.com/api/users/password/"+Function.id+"/"+ first_nameController.text+"/"+ last_nameController.text+"/"+phoneController.text+"/");
      Function.first_name = first_nameController.text;
      Function.last_name = last_nameController.text;
      Function.phone = phoneController.text;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("first_name", first_nameController.text);
      sharedPreferences.setString("last_name", last_nameController.text);
      sharedPreferences.setString("phone", phoneController.text);
    }

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => MyApp()
    ));
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
        title: Text("Changer vos Indentifiants",style: TextStyle(color: Colors.white),),
      ),
      body: Container(

        padding: EdgeInsets.symmetric(vertical: 24,horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
                TextFormField(
                  controller: first_nameController,
                  // ignore: missing_return
                  validator: (val){
                    if(val.trim().length <=  3){
                      return "Longeur incorrecte";
                    }

                    return RegExp(r"\d+$").hasMatch(val.trim()) ? "Ne doit pas contenir de Chiffre" : null;
                  },

                  decoration: InputDecoration(
                    hintText: Function.first_name,
                    icon: Icon(Icons.person,color: Colors.grey,),
                  ),
                ),
              TextFormField(
                validator: (val){
                  if(val.trim().length <=  3){
                    return "Longeur incorrecte";
                  }

                  return RegExp(r"\d+$").hasMatch(val.trim()) ? "Ne doit pas contenir de Chiffre" : null;
                },
                controller: last_nameController,
                  keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: Function.last_name,
                  icon: Icon(Icons.person,color: Colors.grey,),
                ),
              ),
              TextFormField(
                validator: (val){
                  if(val.trim().length !=  8){
                    return "Longeur incorrecte";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                controller: phoneController,

                decoration: InputDecoration(
                  hintText: Function.phone,
                  icon: Icon(Icons.phone,color: Colors.grey,),
                ),
              ),
              SizedBox(height: 20,),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                child: Text("Valider",style: TextStyle(color: Colors.white),),
                onPressed: (){
                      updateInfo();
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
