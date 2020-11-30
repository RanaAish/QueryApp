
import 'package:flutter/cupertino.dart';

class logindata  extends ChangeNotifier
{

      String _email,_pass;
      String get email => _email;
      String get pass =>_pass;
       setpass (String p)
      {
        _pass=p;
      }
       void changedata (String email ,String pass)
       {
         this._email=email;
         this._pass=pass;
         notifyListeners();
       }


}


