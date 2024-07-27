import 'package:hive_flutter/hive_flutter.dart';

class LocalDB {

  static final box = Hive.box('user');

  static saveLogin(value)=>box.put('isLogin', value);

  static saveUserId(value)=>box.put('id', value);
  static saveUserName(value)=>box.put('name', value);
  static saveEmail(value)=>box.put('email', value);
  static saveMobile(value)=>box.put('mobile', value);
  static saveCode(value)=>box.put('code', value);


  static getLogin()=>box.get('isLogin');
  
  static getUserid()=>box.get('id');
  static getUserName()=>box.get('name');
  static getEmail()=>box.get('email');
  static getMobile()=>box.get('mobile');
  static getCode()=>box.get('code');


  static clearDB()=>box.clear();

}