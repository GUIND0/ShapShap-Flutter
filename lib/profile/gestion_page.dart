import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:menu/profile/password_change.dart';
import 'package:menu/profile/personal.dart';
import 'package:menu/widgets/profile_list_item.dart';

import 'add_product.dart';
import 'article.dart';
import 'commande.dart';



class Gestion extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}



class _SettingState extends State<Gestion> {


  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.setState(fn);
  }
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
                title: Text("Gestion",style: TextStyle(color: Colors.white),),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Add()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.plus,
                            text: 'Ajouter un Article',
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Commande()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.list_ol,
                            text: 'Mes Commandes',
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlePage()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.list,
                            text: 'Mes Articles',
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
