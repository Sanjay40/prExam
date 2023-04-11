import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:prexam/view/AddToCart.dart';
import 'package:prexam/view/HomeScreen.dart';

void main(){
  runApp(
    MaterialApp(
     routes: {
       '/' : (context) => HomeData(),
       'addToCart' : (context) => AddToCart()
     },
    ),
  );
}


