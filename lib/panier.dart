import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu/CartModel.dart';
import 'package:http/http.dart' as http;
import 'package:menu/profile/historique_db.dart';
import 'package:toast/toast.dart';

class Panier extends StatefulWidget {
  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {



  List<CartModel> tasks = [];
  int total = 0;
  bool isDone = false;
  CartHelper helper = CartHelper();
  HistoriqueCartHelper historiqueCartHelper = HistoriqueCartHelper();
  @override
  void initState() {

    super.initState();

  }


  Future<List<CartModel>> load() async{
    tasks =  await helper.getModels();
    return tasks;
  }

  totalFonction(List<CartModel> tasks) {
    var i = 0;
    var total1 = 0;
    while(i < tasks.length){
      total1 += (tasks[i].price * tasks[i].quantity);
      i++;
    }

    return total1;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Panier"),centerTitle: true,backgroundColor: Color(0xFFF17532),),
      body: FutureBuilder(
        future: load(),
        // ignore: missing_return
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data == null || snapshot.data == []) {
            return Center(
              child: Container(
                child: Text(
                  "En chargement ...", style: TextStyle(color: Colors.black),),
              ),
            );
          }else{

            total = totalFonction(tasks);

            return (tasks.length == 0) ?Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_basket,size: 100,color: Color(0xFFF17532),),
                    Text("Votre panier est vide. ",style: TextStyle(
                      fontSize: 25,color: Color(0xFFF17532),
                    ),)
                  ],
                )
              ),
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                    child: ListView.separated(
                      itemBuilder: (context,index){
                        return ListTile(
                          leading: Image.network(tasks[index].url,height: 100,width: 100,),
                          subtitle: Text("${tasks[index].price}  FCFA"),
                          title: Text("${tasks[index].name}"),
                          trailing: Column(
                            children: [
                              Text("${tasks[index].quantity}"),
                              GestureDetector(
                                  onTap: (){
                                    helper.deleteDog(tasks[index].product_id).then((value){
                                      setState(() {

                                      });
                                    });
                                  },
                                  child: Icon(Icons.delete,color: Colors.red)
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (Context,index) => Divider(),
                      itemCount: tasks.length,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                    child: Column(
                      children: [
                        Text('Total: ${total} FCFA'),

                        RaisedButton(
                          onPressed: (isDone) ? (){ setState(() {

                          }); } : () async {

                            var jsonData = null;
                            for(var i = 0; i < tasks.length ; i++){
                              Map data = {
                                "vendeur": tasks[i].seller_id.toString(),
                                "client1": tasks[i].buyer_id.toString(),
                                "quantity": tasks[i].quantity.toString(),
                                "product": tasks[i].product_id.toString()
                              };


                              HistoriqueCartModel hist = HistoriqueCartModel(
                                seller_id: tasks[i].seller_id,
                                buyer_id: tasks[i].buyer_id,
                                product_id: tasks[i].product_id,
                                quantity: tasks[i].quantity,
                                name: tasks[i].name,
                                price: tasks[i].price,
                                url: tasks[i].url
                              );

                            //  var response = await http.post("http://shapshapmarket.com/api/create/",body:data);

                            /**  if(response.statusCode == 201){
                                print(" commande done with success");

                                setState(() {
                                   isDone = true;
                                });

                                historiqueCartHelper.insertTask(hist).then((value){
                                  helper.deleteDog(tasks[i].product_id).then((value){
                                  });
                                });


                              }else{
                                jsonData = json.decode(response.body);
                                print(jsonData.toString());
                              }  **/

                              historiqueCartHelper.insertTask(hist).then((value){
                                helper.deleteDog(tasks[i].product_id).then((value){
                                });
                              });
                            setState(() {
                              isDone = true;
                            });

                            }

                            Toast.show("Vos commandes on été enregistrer avec success", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Color(0xFFF17532));


                            },
                          color: Color(0xFFF17532),
                          child: Text("commander",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ),

              ],

            );

          }
          
        }

      ),
    );
  }
}
