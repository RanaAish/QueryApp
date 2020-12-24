import 'package:flutter/cupertino.dart';

class logindata  extends ChangeNotifier
{

  String _email,_pass,_userid;
  String  _totalscore,_firstscore,_secondscore;
  String get email => _email;
  String get pass =>_pass;
  String get userid => _userid;
  String  get totalscore => _totalscore;
  String get firstscore =>_firstscore;
  String get secondscore =>_secondscore;

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

  void getdocumentid (String userid)
  {
    this._userid=userid;
    notifyListeners();
  }

  void  gettotalscore (String score)
  {
    this._totalscore=score;
    notifyListeners();
  }

}

