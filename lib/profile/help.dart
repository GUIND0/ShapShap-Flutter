import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'data.dart';


class Help extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Help> {
  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    slides = getSlide();
  }

  Widget pageIndexIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? Colors.grey : Colors.grey[300],
          borderRadius: BorderRadius.circular(12)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: pageController,
        itemCount: slides.length,
        onPageChanged: (val){
          setState(() {
            currentIndex = val;
          });
        },
        itemBuilder: (context,index){
          return SliderTile(
            ImageAssetPath: slides[index].getpath(),
            desc: slides[index].getDesc(),
            title: slides[index].getTitle(),
          );
        },
      ),
      bottomSheet: currentIndex != (slides.length - 1)?Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                pageController.animateToPage(slides.length - 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
              },
              child: Text('Passer'),
            ),
            Row(
              children: [
                for(int i = 0; i < slides.length; i++)currentIndex == i?pageIndexIndicator(true):pageIndexIndicator(false)
              ],
            ),
            GestureDetector(
              onTap: (){
                pageController.animateToPage(currentIndex + 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
              },
              child: Text('Suivant'),
            ),
          ],
        ),
      ):Container(
        height: 60,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: GestureDetector(
          onTap: (){

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => App()));

          },
          child: Text(
            "Commencer",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
    );
  }
}

getPersistence() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var show = sharedPreferences.getBool("show");
}

initPersistence() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("show", false);
}

class SliderTile extends StatelessWidget {
  String ImageAssetPath,title,desc;
  SliderTile({this.ImageAssetPath,this.title,this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssetPath),
          SizedBox(height: 20,),
          Text(title,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 12,),
          Text(desc,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400
          ),),
        ],
      ),
    );
  }
}
