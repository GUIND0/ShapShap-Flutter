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
import 'detailArticle.dart';


class Modifier extends StatefulWidget {
  Article _article;
  Modifier(Article article){
    _article = article;
  }

  @override
  _AddState createState() => _AddState(_article);
}

class _AddState extends State<Modifier> {

  Article _article;


  _AddState(Article article){
    _article = article;
  }


  File _file;
  final picker = ImagePicker();
  String hint = "Categories";
  String tag = "";
  final key = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  Future getImage() async{
    final file = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(file.path);
    });
  }

  sendProduct(BuildContext context) async{
    var jsonData = null;
    if(_file != null){
      if(tag.isNotEmpty){
        if(key.currentState.validate()){

          upload(context);

        }
      }else{
        Toast.show("Choisissez une catégorie ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));
      }

    }else{

      Toast.show("Choisissez une image ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,backgroundColor: Color(0xFFF17532));


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
    var uri = Uri.parse("http://shapshapmarket.com/api/update/product/"+_article.id.toString()+"/");

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

      _article.name = nameController.text.toString();
      _article.tag = tag;
      _article.description = descController.text.toString();
      _article.price = int.parse(priceController.text);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ArticlePage()));
    });
   // print(response.statusCode);

    // listen for response
    /**response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });**/
  }

  @override
  void initState() {
    priceController.text = _article.price.toString();
    descController.text = _article.description.toString();
    nameController.text = _article.name.toString();
    tag = _article.tag.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFFF17532),
        title: Text("Modifier un Article",style: TextStyle(color: Colors.white),),
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

                          icon: Icon(Icons.attach_money,color: Colors.grey,),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                        width: MediaQuery.of(context).size.width,
                        child: new DropdownButton<String>(

                          isExpanded: true,
                          hint: Text(hint),
                          items: <String>['Vêtement','Chaussure', 'Enfant', 'High Tech','Librairie','Agriculture','Quincaillerie'].map((String value) {
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
                        onPressed: (){
                          sendProduct(context);
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
