import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:menu/CartModel.dart';
import 'package:menu/panier.dart';
import 'package:menu/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'bottom_bar.dart';
import 'package:flutter/material.dart';


class Detail extends StatefulWidget {
  Product _p;
  Detail(Product p){
    _p = p;
  }
  @override
  _DetailState createState() => _DetailState(_p);
}

class _DetailState extends State<Detail> {
  SharedPreferences sharedPreferences ;
  String prenom = "";
  String nom = "";
  String id = "";
  bool isClick = false;

  Product _p;
  _DetailState(Product p){
    _p = p;
  }
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    loadUserInfo();
  }

  loadUserInfo() async{
    sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString("id");
  }

  AlreadyInCartFonction(List<CartModel> tasks,var id) {
    for(var i=0;i < tasks.length; i++){
        if(tasks[i].product_id == id){
          return true;
        }
    }
    return false;

  }

  @override
  Widget build(BuildContext context) {
    CartHelper helper = CartHelper();


    int _currentIntValue = 1;
    int _quantite = 1;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFFF17532),
        elevation: 0.0,
        centerTitle: true,
        title: Text("ShapShap Market",style: TextStyle(
            color: Colors.white
        ),),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),

      ),
      body: ListView(
        children: [
          SizedBox(height: 15.0,),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              _p.owner,
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
            child: RaisedButton(
              color: Color(0xFFF17532),
              textColor: Colors.white,
              child: Text("Quantité"),
              onPressed: () => showMaterialNumberPicker(
                headerColor: Color(0xFFF17532),
                buttonTextColor: Color(0xFFF17532),
                context: context,
                title: "Combien en voulez-vous ?",
                maxNumber: 100,
                minNumber: 0,
                confirmText: "Valider",
                cancelText: "Annuler",
                selectedNumber: 0,
                  onChanged: (value) {
                    _quantite = value;

                  }
              ),
          ),
          ),

          SizedBox(height: 20.0,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
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
            onTap: () async{
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              if(sharedPreferences.getString("id") != null || true){

                  if(AlreadyInCartFonction(await helper.getModels(),_p.id)){
                    Toast.show("Ce article est déja dans le panier", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));
                  }else{

                    CartModel currentTask = CartModel(seller_id: _p.owner_id,buyer_id: int.parse(id),product_id: _p.id,quantity: _quantite,price: _p.price,name: _p.name,url: _p.image);

                    helper.insertTask(currentTask);



                    Toast.show("Ajouté au Panier", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));

                  }

              }else{
                print("null");
              }

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
                      'Ajouter au Panier',
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
