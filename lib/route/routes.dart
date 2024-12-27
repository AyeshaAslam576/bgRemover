import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../views/rembg.dart';
class Routes{
  static const String home="/rembg.dart";
  static final List<GetPage> myPages =[
    GetPage(name: home, page:()=>Rembg()),
  ];
}
