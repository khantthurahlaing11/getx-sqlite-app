
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const  bluishClr = Color(0xFF4e5ae8);
const  yellowClr = Color(0xFFFFB746);
const  pinkClr = Color(0xFFff4667);
const  white = Colors.white;
const primaryClr = bluishClr;
const darkGreyClr = Color(0xFF121212);
const darkHeaderClr = Color(0xFF424242);

class Themes{
  static final light = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light(

      brightness: Brightness.light,
      primary: Colors.white,
      
    )
  );

  static final dark = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark(

      brightness: Brightness.dark,
      primary: darkGreyClr
    )
  );

}


  TextStyle get subHeadingStyle{
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode? Colors.grey[400] : Colors.grey
      )
    );
  }

    TextStyle get headingStyle{
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode? Colors.white : Colors.black
      )
    );
  }

     TextStyle get titleStyle{
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode? Colors.white : Colors.black
      )
    );
  }

      TextStyle get subtitleStyle{
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode? Colors.grey[100] : Colors.grey[600]
      )
    );
  }

