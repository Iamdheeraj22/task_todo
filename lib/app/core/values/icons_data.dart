import 'package:flutter/cupertino.dart';
import 'package:task_todo/app/core/values/colors.dart';

class IconsData {
  //Create Singleton class instance
  static final IconsData _icons = IconsData._internal();

  //Private constructor
  IconsData._internal();

  //Factory constructor
  factory IconsData() {
    return _icons;
  }

  static const personIcon = 0xe491;
  static const workIcon = 0xe11c;
  static const movieIcon = 0xe40f;
  static const sportIcon = 0xe4dc;
  static const travelIcon = 0xe071;
  static const shopIcon = 0xe59c;

  List<Icon> getIcons() {
    return const [
      Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: purple),
      Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: pink),
      Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: green),
      Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'), color: yellow),
      Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: deepPink),
      Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color: lightBlue),
    ];
  }
}
