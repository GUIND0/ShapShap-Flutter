import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:menu/CartModel.dart';
import 'package:menu/panier.dart';
import 'package:menu/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'article.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'modify_article.dart';


class ArticleDetail extends StatefulWidget {
  Article _p;
  ArticleDetail(Article p){
    _p = p;
  }
  @override
  _DetailState createState() => _DetailState(_p);
}

class _DetailState extends State<ArticleDetail> {
  SharedPreferences sharedPreferences;

  String prenom = "";
  String nom = "";
  String id = "";

  Article _p;

  _DetailState(Article p) {
    _p = p;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserInfo();
  }


  deleteProduct() async{
    var jsonData = null;
    var response = await http.post("http://shapshapmarket.com/api/delete/"+_p.id.toString())
    .then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ArticlePage()));
    });
  }


  loadUserInfo() async {
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
        title: Text("Gestion Article",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 15.0,),

          SizedBox(height: 15.0),
          Hero(
            tag: _p.id,
            child: Container(
              height: 200.0,
              width: 175.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(_p.image)
                  )
              ),
            ),
          ),

          SizedBox(height: 20.0,),
          Center(
            child: Text(
              _p.price.toString(),
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
              _p.name,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 24.0,
                  color: Color(0xFF575E67)
              ),
            ),
          ),

          SizedBox(height: 10,),
          Center(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 50.0,
              child: Text(
                _p.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9)
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          GestureDetector(
            onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Modifier(_p)));
            },
            child: Center(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.teal
                ),

                child: Center(
                  child: Text(
                    'Modifier',
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
          SizedBox(height: 20.0,),
          GestureDetector(
            onTap: () async {
              showDialog(
                  context: context,
                builder: (_) => AlertDialog(
                  title: Text("Voulez-vous vraiment supprimer ?"),
                  content: Text("La suppression d'un article est definitive"),
                  actions: [
                    FlatButton(
                      child: Text("Non"),
                      onPressed: (){
                        Navigator.pop(_);
                      },
                    ),
                    FlatButton(
                      child: Text("oui"),
                      onPressed: (){
                        Navigator.pop(_);
                        deleteProduct();
                      },
                    ),
                  ],
                )
              );
            },
            child: Center(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.red
                ),

                child: Center(
                  child: Text(
                    'Supprimer',
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