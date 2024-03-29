import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/query.dart';
import 'package:ecommerce/const.dart';
import 'package:ecommerce/model/user.dart';
import 'package:ecommerce/model/question.dart';
class store
{
  Firestore firestore =Firestore.instance;

  addquery (query q)
  {
    firestore.collection(kdatabase).add({
      kQuerytitle:q.title,
      kQuerydesc:q.des,
      kQuerycategory:q.category,
      kcategoryscore:q.score
    });
  }


  updatecategory (data,docmentid)
  {
    firestore.collection(kdatabase).document(docmentid).updateData(data);
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
      kuserpicture:u.pic,
      kuserscore:u.totalscore
    });
  }

  updatedata (data,docmentid)
  {
    firestore.collection(kdbusers).document(docmentid).updateData(data);
  }


  addquesion (quesion que)
  {
    firestore.collection(kquesion).add({
      kquetitle:que.title,
      kcqueryid:que.query_id,
      kquecorrectanswer:que.correctanswer,
      kquelistofoptions:que.list_of_choices
    });
  }

  loadquestion()
  {
    return  firestore.collection(kquesion).snapshots();
  }
}
