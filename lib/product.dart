import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'detail.dart';

class ProductPage extends StatefulWidget {
      String url = "";
  ProductPage(String chemin){
    url = chemin;
  }


  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  Future<List<Product>> _getProduct() async{
    var data = await http.get(widget.url);
    String source = Utf8Decoder().convert(data.bodyBytes);
    var jsonData = json.decode(source);
    List<Product> products = [];

    for(var i in jsonData){
      Product product = Product(i["id"],i["name"],i["image"],i["price"],i["description"],i["owner_id"],i["owner"]);
      products.add(product);
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder(
            future: _getProduct(),
           builder: (BuildContext context,AsyncSnapshot snapshot){

            if(snapshot.data == null){
              return Center(
                child: Container(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFCC8053)),
                  ),
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
                    height: MediaQuery.of(context).size.height - 250.0,
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
        ),
      ),
    );
  }
}





class Product {
  final int id;
  final int owner_id;
  final String owner;
  final String name;
  final String image;
  final int price;
  final String description;

  Product(this.id, this.name,this.image, this.price, this.description, this.owner_id, this.owner);

}