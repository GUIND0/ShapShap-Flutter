import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
  @override
  Widget build(BuildContext context) {
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

  String prenom = "";
  String nom = "";
  String phone = "";
  String email = "";
  @override
  void initState() {

    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    _tabController = TabController(length: 6,vsync: this);

    checkLoginStatus();

    loadUserInfo();

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
      appBar: AppBar(
        backgroundColor: Color(0xFFF17532),
        elevation: 0.0,
        centerTitle: true,
        title: Text("ShapShap Market",style: TextStyle(
          color: Colors.white,
        ),),

        actions: [

        ],
      ),
      body: ListView(
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
                child: Text("Livre",style: TextStyle(
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

            ],
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Vêtement"),
                  ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Chaussure"),
                  ProductPage("http://shapshapmarket.com/api/tag/product/?tag=High Tech"),
                  ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Livre"),
                  ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Enfant"),
                  ProductPage("http://shapshapmarket.com/api/tag/product/?tag=Agriculture"),
                ],
              ),
            ),
          ),

        ],
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

