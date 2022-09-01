import 'package:flutter/material.dart';

int getDate(String str){
  return int.parse(str.substring(0,2));
}
int getMonth(String str){
  return int.parse(str.substring(2,4));
}
int getYear(String str){
  return int.parse(str.substring(4,6));
}