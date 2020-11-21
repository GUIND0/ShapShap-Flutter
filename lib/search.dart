import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:menu/panier.dart';
import 'package:menu/product.dart';

import 'bottom_bar.dart';
import 'detail.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {



  bool isClick = false;

  TextEditingController searchController = TextEditingController();


  Future<List<Product>> _getProduct() async{
    var data = await http.get("http://shapshapmarket.com/api/products/?name="+searchController.text);
    var jsonData = json.decode(data.body);
    List<Product> products = [];

    for(var i in jsonData){
      Product product = Product(i["id"],i["name"],i["image"],i["price"],i["description"],i["owner_id"],i["owner"]);
      products.add(product);
    }

    return products;
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
          child: Column(
            children: [
              Container(
                color: Color(0xFFF17532),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                            hintText: "Rechercher un produit",
                            hintStyle: TextStyle(
                                color: Colors.white54
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                       setState(() {
                         isClick = true;
                         SystemChrome.setEnabledSystemUIOverlays([]);
                       });
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: Icon(Icons.search,color: Colors.white,size: 40,)
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: isClick ? FutureBuilder(
                    future: _getProduct(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){

                      if(snapshot.data == null){
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
                              padding: EdgeInsets.only(right: 15.0,left: 15.0),
                              width: MediaQuery.of(context).size.width - 30.0,
                              height: MediaQuery.of(context).size.height - 300.0,
                              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                // ignore: missing_return
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context,int index){
                                  return Padding(
                                    padding: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 5.0,right: 5.0),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(snapshot.data[index])));
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
                                                        image: NetworkImage(snapshot.data[index].image)
                                                    )
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 7.0,),
                                            Text("${snapshot.data[index].price.toString()} FCFA",
                                              style: TextStyle(
                                                  color: Color(0xFFCC8053),
                                                  fontFamily: 'Varela',
                                                  fontSize: 16.0
                                              ),),
                                            Text(snapshot.data[index].name,
                                              style: TextStyle(
                                                  color: Color(0xFFCC8053),
                                                  fontFamily: 'Varela',
                                                  fontSize: 18.0
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
                  ) : Container(color: Colors.white,),
                ),
              ),

            ],
          ),
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
