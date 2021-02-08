import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:menu/helper/functions.dart';

import 'commande_detail.dart';

class Commande extends StatefulWidget {
  @override
  _CommandeState createState() => _CommandeState();
}

class _CommandeState extends State<Commande> {

  Future<List<CommandeClass>> _getCommande() async{
    var data = await http.get("http://shapshapmarket.com/api/commandes/?vendeur="+Function.id);
    String source1 = Utf8Decoder().convert(data.bodyBytes);
    var jsonData = json.decode(source1);
    List<CommandeClass> commandes = [];

    for(var i in jsonData){
      CommandeClass commande = CommandeClass(i["id"],i["client_name"],i["product"],i["product_name"],i["product_price"], i["quantity"],"http://shapshapmarket.com/" + i["url"],i["phone"],i["date"]);
      commandes.add(commande);
    }

    return commandes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFFF17532),
        title: Text("Mes Commandes",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder(
          future: _getCommande(),
          builder: (BuildContext context,AsyncSnapshot snapshot){

            if(snapshot.data == null){
              print("http://shapshapmarket.com/api/commandes/?vendeur="+Function.id);
              return Center(
                child: Container(
                  child: Text("En chargement ...",style: TextStyle(color: Colors.black),),
                ),
              );



            }else{
              print(snapshot.data.toString());
              return ListView(
                children: [
                  SizedBox(height: 15.0,),
                  Container(
                    padding: EdgeInsets.only(right: 15.0),
                    width: MediaQuery.of(context).size.width - 30.0,
                    height: MediaQuery.of(context).size.height - 100.0,
                    child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      // ignore: missing_return
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,int index){
                        return Padding(
                          padding: EdgeInsets.only(top: 5.0,bottom: 0,left: 15.0,right: 5.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CommandeDetail(snapshot.data[index])));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3.0,
                                    blurRadius: 5.0,
                                  )
                                ],
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Hero(
                                    tag: snapshot.data[index].id,
                                    child: Container(
                                      height: 100.0,
                                      width: 175.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(snapshot.data[index].url)
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Text(snapshot.data[index].product_name,
                                    style: TextStyle(
                                        color: Color(0xFFCC8053),
                                        fontFamily: 'Varela',
                                        fontSize: 15.0
                                    ),),
                                  Text(snapshot.data[index].product_price.toString() + " FCFA  -  " + snapshot.data[index].quantity.toString(),
                                    style: TextStyle(
                                        color: Color(0xFFCC8053),
                                        fontFamily: 'Varela',
                                        fontSize: 15.0
                                    ),),
                                  Text( "Client : " + snapshot.data[index].client_name,
                                    style: TextStyle(
                                        color: Color(0xFFCC8053),
                                        fontFamily: 'Varela',
                                        fontSize: 15.0
                                    ),),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}


class CommandeClass {
  final int id;
  final String url;
  final String client_name;
  final int product_id;
  final String product_name;
  final int product_price;
  final int quantity;
  final String phone;
  final String date;

  CommandeClass(this.id, this.client_name, this.product_id, this.product_name, this.product_price,  this.quantity, this.url, this.phone, this.date);

}
