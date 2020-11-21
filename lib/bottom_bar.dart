import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu/profile.dart';
import 'package:menu/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class BottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)
          ),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2  - 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      child: Icon(Icons.home,color: Color(0xFFEF7532),size: 30
                      ),
                    onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => App()));
                    },
                  ),
                  GestureDetector(
                      child: Icon(Icons.person_outline,color: Color(0xFFEF7532),size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2  - 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Icon(Icons.search,color: Color(0xFFEF7532),size: 30),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                    },
                  ),
                  GestureDetector(
                    child: Icon(Icons.power_settings_new,color: Color(0xFFEF7532),size: 30),
                    onTap: () async{
                      SystemNavigator.pop();
                    },
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
