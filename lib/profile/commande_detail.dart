import 'package:flutter/cupertino.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:menu/CartModel.dart';
import 'package:menu/panier.dart';
import 'package:menu/product.dart';
import 'package:menu/profile/commande.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bottom_bar.dart';


class CommandeDetail extends StatefulWidget {
  CommandeClass _p;
  CommandeDetail(CommandeClass p){
    _p = p;
  }
  @override
  _DetailState createState() => _DetailState(_p);
}

class _DetailState extends State<CommandeDetail> {
  SharedPreferences sharedPreferences ;
  String prenom = "";
  String nom = "";
  String id = "";

  CommandeClass _p;
  _DetailState(CommandeClass p){
    _p = p;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserInfo();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print(url);
     // throw 'Could not launch $url';
    }
  }

  loadUserInfo() async{
    sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString("id");
  }

  @override
  Widget build(BuildContext context) {
    CartHelper helper = CartHelper();


    int _currentIntValue = 1;
    int _quantite = 1;

    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFFF17532),
        title: Text("Info",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 15.0,),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              _p.product_name,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532)),
            ),
          ),
          SizedBox(height: 15.0),
          Hero(
            tag: _p.id,
            child: Container(
              height: 200.0,
              width: 175.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(_p.url)
                  )
              ),
            ),
          ),

          SizedBox(height: 20.0,),
          Center(
            child: Text(
              _p.product_price.toString() + " FCFA " ,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532)
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text(
              "Info du Client : ",
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 24.0,
                  color: Color(0xFF575E67)
              ),
            ),
          ),

          SizedBox(height: 10,),
          Center(
            child: Text(
              "Indentifiant : "  + _p.client_name,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 24.0,
                  color: Color(0xFF575E67)
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Center(
            child: Text(
              "Téléphone :  ${_p.phone} ",
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 24.0,
                  color: Color(0xFF575E67)
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Center(
            child: Text(
              "Date :  ${_p.date.substring(0,10)} ",
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 24.0,
                  color: Color(0xFF575E67)
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          GestureDetector(
            onTap: (){
              _launchURL("tel:"+_p.phone);
            },
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xFFF17532)
                ),

                child: Center(
                  child: Text(
                    'APPELER',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0,),
        ],
      ),


    );
  }
}
