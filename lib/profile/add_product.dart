import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu/helper/functions.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toast/toast.dart';

import 'article.dart';


class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  File _file;
  final picker = ImagePicker();
  String hint = "Categories";
  String tag = "";
  final key = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  bool isPress = false;

  Future getImage() async{
    final file = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(file.path);
    });
  }

  sendProduct(BuildContext context) async{
     var url =  "http://shapshapmarket.com/api/add/product/";
     var jsonData = null;
     if(_file != null){
       if(tag.isNotEmpty){
         if(key.currentState.validate()){

           upload(context);

         }
       }else{
         Toast.show("Veillez choisir une Catégorie", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));

       }

     }else{
       Toast.show("Veillez choisir une image dans votre galerie ", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));


     }

  }



  upload(BuildContext context) async {
    // open a bytestream
   // var stream = new http.ByteStream(DelegatingStream.typed(_file.openRead()));

    var stream  = new http.ByteStream(_file.openRead());
    stream.cast();

    // get file length
    var length = await _file.length();

    // string to uri
    var uri = Uri.parse("http://shapshapmarket.com/api/add/product/");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length, filename: basename(_file.path));

    request.files.add(multipartFile);

    request.fields['name'] = nameController.text;
    request.fields['description'] = descController.text;
    request.fields['tag'] = tag;
    request.fields['price'] = priceController.text;
    request.fields['owner'] = Function.id;


    // add file to multipart



    // send
    var response = await request.send().then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ArticlePage() ));
    });

    /**print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    }); **/

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFFF17532),
        title: Text("Ajouter un Article",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Form(
              key: key,
              child: Column(
                    children: [
                        GestureDetector(
                          onTap: (){
                            getImage();
                          },
                          child: Container(
                            color: Colors.grey,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: _file == null ? Icon(Icons.panorama) : Image.file(_file,width: MediaQuery.of(context).size.width,height: 200,),
                          ),
                        ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            TextFormField(

                              controller: nameController,
                              // ignore: missing_return
                              validator: (val){
                                  if(val.length < 3){
                                    return "Longueur incorrect";
                                  }
                                return  null;
                              },

                              decoration: InputDecoration(
                                hintText: "Nom de l'article",
                                icon: Icon(Icons.text_fields,color: Colors.grey,),
                              ),
                            ),

                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: descController,
                              // ignore: missing_return
                              validator: (val){
                                if(val.length < 3){
                                  return "Longueur incorrect";
                                }
                                return  null;
                              },
                              decoration: InputDecoration(
                                hintText: "Description",
                                icon: Icon(Icons.wrap_text,color: Colors.grey,),
                              ),
                            ),

                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              // ignore: missing_return
                              validator: (val){
                                if(val.length < 3){
                                  return "Longueur incorrect";
                                }
                                return  null;
                              },


                              decoration: InputDecoration(
                                hintText: "Prix",
                                icon: Icon(Icons.attach_money,color: Colors.grey,),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                              width: MediaQuery.of(context).size.width,
                              child: new DropdownButton<String>(

                                isExpanded: true,
                                hint: Text(hint),
                                items: <String>['Vêtement','Chaussure','Sport et Loisir', 'Enfant', 'High Tech','Livre','Agriculture'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {

                                  setState(() {
                                    hint =  "Catégories : "  + _.toString();
                                    tag = _.toString();
                                  });

                                },
                              ),
                            ),

                            FlatButton(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              color: Color(0xFFF17532),
                              onPressed: isPress ? null : (){
                                  sendProduct(context);
                                  setState(() {
                                    isPress = true;
                                  });
                              },
                              child: Text("Publier",style: TextStyle(
                                color: Colors.white
                              ),),
                            )

                          ],
                        ),
                      ),

                    ],
              ),
            ),
        ),
      ),
    );
  }
}
