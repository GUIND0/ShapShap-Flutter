import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:menu/helper/functions.dart';

import 'commande_detail.dart';
import 'detailArticle.dart';

class ArticlePage extends StatefulWidget {
  @override
  _CommandeState createState() => _CommandeState();
}

class _CommandeState extends State<ArticlePage> {

  Future<List<Article>> _getArticle() async{
    var data = await http.get("http://shapshapmarket.com/api/my/product/?owner="+Function.id);
    String source1 = Utf8Decoder().convert(data.bodyBytes);
    var jsonData = json.decode(source1);
    List<Article> articles= [];

    for(var i in jsonData){
      Article article = Article(i["id"],i["name"],i["description"],i["price"],i["image"],i["tag"],i["owner"]);
      articles.add(article);
    }

    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFFF17532),
        title: Text("Mes Articles",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder(
          future: _getArticle(),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetail(snapshot.data[index])));
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
                                  SizedBox(height: 5.0,),
                                  Text(snapshot.data[index].name,
                                    style: TextStyle(
                                        color: Color(0xFFCC8053),
                                        fontFamily: 'Varela',
                                        fontSize: 15.0
                                    ),),
                                  Text(snapshot.data[index].price.toString() + " FCFA ",
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


class Article {
   int id;
  String name;
   String description;
   int price;
   String image;
   String tag;
   int owner_id;

  setName(String nameF){
    this.name = nameF;
  }

  Article(this.id, this.name, this.description, this.price, this.image, this.tag, this.owner_id);


}
