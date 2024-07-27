import 'package:flutter/material.dart';

extension Navigation on BuildContext {

  navigateTo(String path, {args})=>Navigator.of(this).pushNamed(path, arguments: args);
  back()=>Navigator.pop(this);

}