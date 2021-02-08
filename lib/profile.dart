import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:menu/helper/functions.dart';
import 'package:menu/login.dart';
import 'package:menu/panier.dart';
import 'package:menu/profile/gestion_page.dart';
import 'package:menu/profile/help.dart';
import 'package:menu/profile/historique_page.dart';
import 'package:menu/profile/setting.dart';
import 'package:menu/widgets/profile_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_bar.dart';
import 'constants.dart';
import 'main.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;

@override
  void initState() {
    // TODO: implement initState
   SystemChrome.setEnabledSystemUIOverlays([]);
    print("++++++++++++++++"+Function.types);
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
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences sharedPreferences;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    load();

  }

  load() async{
    sharedPreferences =
    await SharedPreferences.getInstance();
  }


  @override
  Widget build(BuildContext context) {
      ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
      var profileInfo = Expanded(
        child: Column(
          children: <Widget>[

            SizedBox(height: kSpacingUnit.w * 5),
            Text(
              Function.first_name+" "+Function.last_name,
              style: TextStyle(
                color: Color(0xFFF17532),
                fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: kSpacingUnit.w * 1),
            Text(
              Function.email,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: kSpacingUnit.w * 1),
              Text(
                Function.phone,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            SizedBox(height: kSpacingUnit.w * 2),
          ],
        ),
      );

      var themeSwitcher = ThemeSwitcher(
        builder: (context) {
          return AnimatedCrossFade(
            duration: Duration(milliseconds: 200),
            crossFadeState:
            ThemeProvider
                .of(context)
                .brightness == Brightness.dark
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: GestureDetector(
              onTap: () =>
                  ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
              child: Icon(
                LineAwesomeIcons.sun,
                size: ScreenUtil().setSp(kSpacingUnit.w * 3),
              ),
            ),
            secondChild: GestureDetector(
              onTap: () =>
                  ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
              child: Icon(
                LineAwesomeIcons.moon,
                size: ScreenUtil().setSp(kSpacingUnit.w * 3),
              ),
            ),
          );
        },
      );

      var header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: kSpacingUnit.w * 3),

          profileInfo,

          SizedBox(width: kSpacingUnit.w * 3),
        ],
      );

      return ThemeSwitchingArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                actions: [
                  themeSwitcher,
                ],
                backgroundColor: Color(0xFFF17532),
                centerTitle: true,
                title: Text("Profile",style: TextStyle(color: Colors.white),),
              ),
              body: Function.types == "vendeur" ? Column(
                children: <Widget>[
                  SizedBox(height: kSpacingUnit.w * 0.5),
                  header,
                  Expanded(
                    child: ListView(
                      children: <Widget>[

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Gestion()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.history,
                            text: 'Gestion des Articles',
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Historique()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.history,
                            text: 'Historique',
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.question_circle,
                            text: 'Aide',
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.cog,
                            text: 'Paramètre',
                          ),
                        ),

                        GestureDetector(
                          onTap: () async {

                              sharedPreferences.remove('token');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginApp() ));


                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.alternate_sign_out,
                            text: 'Déconnexion',
                            hasNavigation: false,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ) : Column(
                children: <Widget>[
                  SizedBox(height: kSpacingUnit.w * 0.5),
                  header,
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Historique()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.history,
                            text: 'Historique',
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.question_circle,
                            text: 'Aide',
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.cog,
                            text: 'Paramètre',
                          ),
                        ),

                        GestureDetector(
                          onTap: () async {

                            sharedPreferences.remove('token').then((
                                value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginApp()), (
                                  Route<dynamic>route) => false);
                            });
                          },
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.alternate_sign_out,
                            text: 'Déconnexion',
                            hasNavigation: false,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Panier()));
                },
                backgroundColor: Color(0xFFF17532),
                child: Icon(Icons.shopping_basket,color: Colors.white,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomBar(),
            );
          },
        ),
      );

      //
  }
}

