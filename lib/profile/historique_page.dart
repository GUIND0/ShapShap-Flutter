import 'package:flutter/material.dart';
import 'package:menu/profile/historique_db.dart';


class Historique extends StatefulWidget {
  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
   List<HistoriqueCartModel> tasks = [];
    HistoriqueCartHelper helper = HistoriqueCartHelper();

  Future<List<HistoriqueCartModel>> load() async{
    tasks =  await helper.getModels();
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Historique",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xFFF17532),
      ),
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
                    print(tasks.length);
              return
                  Container(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                      child: ListView.separated(
                        itemBuilder: (context,index){

                          return ListTile(
                            onTap: (){
                             // helper.deleteDog(tasks[index].product_id).then((value){});
                            },
                            leading: Image.network(tasks[index].url,height: 100,width: 100,),
                            subtitle: Text("${tasks[index].price}  FCFA"),
                            title: Text("${tasks[index].name}"),
                            trailing: Text("${tasks[index].quantity}"),
                          );
                        },
                        separatorBuilder: (Context,index) => Divider(),
                        itemCount: tasks.length,
                      ),
                    ),
                  );

            }

          }

      ),
    );
  }
}
