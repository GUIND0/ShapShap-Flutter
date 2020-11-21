import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:menu/profile/password_change.dart';
import 'package:menu/profile/personal.dart';
import 'package:menu/widgets/profile_list_item.dart';



class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ThemeSwitchingArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: Color(0xFFF17532),
                title: Text("Paramètres",style: TextStyle(color: Colors.white),),
                centerTitle: true,
              ),
              body: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Expanded(
                    child: ListView(
                      children: <Widget>[

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Identifiant()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.user_shield,
                            text: 'Changer Indentifiant',
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Password()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.history,
                            text: 'Changer Mot de passe',
                          ),
                        ),


                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
