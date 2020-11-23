import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class provider extends ChangeNotifier
{
  // modelhut
  bool isloading=false;
   changeisloading (bool value)
  {
    isloading=value;
    notifyListeners();
  }
}