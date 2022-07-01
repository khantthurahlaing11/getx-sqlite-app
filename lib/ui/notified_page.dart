import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gettest/ui/theme.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({ Key? key,required this.label }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        centerTitle: true,
        backgroundColor: Get.isDarkMode? Colors.grey[600]: primaryClr,
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back,color: Get.isDarkMode? Colors.white:Colors.white,)),
        title: Text(this.label.toString().split("|")[0],style: TextStyle(color: Colors.white),),
      ),
      body: Column(
         
          children: [
            SizedBox(height: 20,),
              Center(
                child: Text("Hello, KTYH",style: TextStyle(
                color:Get.isDarkMode? Colors.black : Colors.black,fontSize: 25),),
              ),
               Center(
                 child: Text("You have a new reminder",style: TextStyle(
              color:Get.isDarkMode? Colors.black : Colors.grey[600],fontSize: 20),),
               ),
               SizedBox(height: 20,),
             Container(
          padding: EdgeInsets.all(25),
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode? Colors.white : primaryClr
          ),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.text_format,color: Colors.white,size: 37,),
                  SizedBox(width: 10,),
                  Text("Title",style: TextStyle(
              color:Get.isDarkMode? Colors.black : Colors.white,fontSize: 30),)
                ],
              ),
              SizedBox(height: 20,),
              Text(this.label.toString().split("|")[0],style: TextStyle(
              color:Get.isDarkMode? Colors.black : Colors.white,fontSize: 20),),
               SizedBox(height: 25,),
              Row(
                children: [
                  Icon(Icons.description_outlined,color: Colors.white,size: 37,),
                  SizedBox(width: 10,),
                  Text("Description",style: TextStyle(
              color:Get.isDarkMode? Colors.black : Colors.white,fontSize: 30),)
                ],
              ),
              SizedBox(height: 20,),
              Text(this.label.toString().split("|")[1],style: TextStyle(
              color:Get.isDarkMode? Colors.black : Colors.white,fontSize: 20),),
                 SizedBox(height: 25,),
              Row(
                children: [
                  Icon(Icons.access_time_rounded,color: Colors.white,size: 37,),
                  SizedBox(width: 10,),
                  Text("Time",style: TextStyle(
              color:Get.isDarkMode? Colors.black : Colors.white,fontSize: 30),)
                ],
              ),
              SizedBox(height: 20,),
              Text("8:00 AM",style: TextStyle(
              color:Get.isDarkMode? Colors.black : Colors.white,fontSize: 20),)
            ],
          ),
        ),
          ],
        )
      
    );
  }
}