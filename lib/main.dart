import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:menu/helper/functions.dart';
import 'package:menu/panier.dart';
import 'package:menu/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_bar.dart';
import 'login.dart';

void main (){

    runApp(App());
}



class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {


  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Home(),

    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController _tabController;
  SharedPreferences sharedPreferences;
  FlutterLocalNotificationsPlugin flutterNotifiaction;

  String prenom = "";
  String nom = "";
  String phone = "";
  String email = "";
  @override
  void initState() {

    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    _tabController = TabController(length: 7,vsync: this);

    var android = new AndroidInitializationSettings('logo');
    var ios = new IOSInitializationSettings();
    var initialisationSetting = new InitializationSettings(android, ios);
    flutterNotifiaction = new FlutterLocalNotificationsPlugin();
    flutterNotifiaction.initialize(initialisationSetting, onSelectNotification: notificationSelected);


    checkLoginStatus();

    loadUserInfo();

  }

  Future notificationSelected(String payload) async{

  }

  Future showNotification() async{
    var androidDetail = new AndroidNotificationDetails('channelId', 'channelName', 'channelDescription',importance: Importance.Max);
    var iosDetail = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(androidDetail, iosDetail);

    await flutterNotifiaction.show(0, 'BIENVENU SUR SHAPSHAP MARKET', 'Des produits de qualité au meilleur prix', generalNotificationDetails);
  }


  loadUserInfo() async{
    sharedPreferences = await SharedPreferences.getInstance();
    Function.id  = sharedPreferences.getString("id");
    Function.first_name  = sharedPreferences.getString("first_name");
    Function.last_name = sharedPreferences.getString("last_name");
    Function.phone = sharedPreferences.getString("phone");
    Function.email = sharedPreferences.getString("email");
    Function.types = sharedPreferences.getString("types");
    Function.password = sharedPreferences.getString("password");


  }

  checkLoginStatus() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null || sharedPreferences.getString("token") == ""){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginApp()),(Route<dynamic>route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Color(0xFFF17532),
          elevation: 0.0,
          centerTitle: true,
          title: Text("ShapShap Market",style: TextStyle(
            color: Colors.white,
          ),),

        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(left: 20.0),
          children: [
            SizedBox(height: 15.0,),
            Text('Categories',
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15.0,),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Color(0xFFC88D67),
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text("Vêtement",style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0
                  ),),
                ),
                Tab(
                  child: Text("Chaussure",style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 21.0
                  ),),
                ),
                Tab(
                  child: Text("High Tech",style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 21.0
                  ),),

                ),


                Tab(
                  child: Text("Librairie",style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 21.0
                  ),),

                ),


                Tab(
                  child: Text("Enfant",style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 21.0
                  ),),

                ),


                Tab(
                  child: Text("Agriculture",style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 21.0
                  ),),

                ),

                Tab(
                  child: Text("Quincaillerie",style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 21.0
                  ),),

                ),

              ],
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 150.0,
                width: double.infinity,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Vêtement"),
                    ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Chaussure"),
                    ProductPage("http://shapshapmarket.com/api/tag/product/?tag=High Tech"),
                    ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Librairie"),
                    ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Enfant"),
                    ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Agriculture"),
                    ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Quincaillerie"),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Panier()));
        },
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.shopping_basket),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}

