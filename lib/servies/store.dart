import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/query.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/model/user.dart';
class store
{
  Firestore firestore =Firestore.instance;
   addquery (query q)
  {
        firestore.collection(kdatabase).add({
          kQuerytitle:q.title,
          kQuerydesc:q.des,
          kQuerycategory:q.category
        });
  }
  Stream loadquery ()
  {
    // listen for update
    return  firestore.collection(kdatabase).snapshots();
  }
  Stream loaduser()
  {
    return  firestore.collection(kdbusers).snapshots();
  }

  adduser(user u)
  {
    firestore.collection(kdbusers).add({
      kusername:u.name,
      kuserpass:u.pass,
      kuseremail:u.email,
      kuserpassconfirmed:u.passconfirmed,
      kuserpicture:u.pic
    });


  }
}