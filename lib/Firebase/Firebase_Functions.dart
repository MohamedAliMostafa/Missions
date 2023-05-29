import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Model/Model.dart';
import 'package:to_do/Model/UserModer.dart';

class FirebaseF {
 static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.FromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static void addTaskToFirestore(TaskModel taskModel) {
    var collec = getCollection();
    var doch = collec.doc();
    taskModel.id = doch.id;
    doch.set(taskModel);
  }
  static Stream<QuerySnapshot<TaskModel>>getdataFromFirstore(DateTime dateTime)
  {
    var collection=getCollection();
    return collection.where("Userid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("date",isEqualTo:DateUtils.dateOnly(dateTime).microsecondsSinceEpoch ).snapshots();

  }
  static Future<void> deleteOldData()
  async {
    QuerySnapshot<TaskModel> tasks= await getCollection().where("date",isLessThan: DateUtils.dateOnly(DateTime.now()).microsecondsSinceEpoch).get();
    var t=tasks.docs.map((e) => e.data()).toList();
    t.forEach((element) {
      getCollection().doc(element.id).delete();
    });
  }
  static Future<void> DeleteData(String id)
  {
    return getCollection().doc(id).delete();
  }
 static Future<void> Update(String id,TaskModel taskModel)
 {
   return getCollection().doc(id).update(taskModel.toJson());
 }
 static CollectionReference<UserModel> getUserCollection() {
   return FirebaseFirestore.instance
       .collection(UserModel.NameModel)
       .withConverter<UserModel>(
     fromFirestore: (snapshot, options) {
       return UserModel.FromJson(snapshot.data()!);
     },
     toFirestore: (value, options) {
       return value.toJson();
     },
   );
 }
 static Future<void> addUserToFirestore(UserModel userModel) {
   var collec = getUserCollection();
   var doch = collec.doc(userModel.id);
  return doch.set(userModel);
 }

 static Future<void> CreateAuthAccount(String name ,String age,String email,String pass,Function shows,Function AfterToAdd)
 async {
   try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: pass,
     );
     UserModel userModel=UserModel(id:credential.user!.uid,name: name, age: age, email:email );
     if(credential.user!.uid !=null) {
         await addUserToFirestore(userModel);
         AfterToAdd();
     }
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     }
     else if (e.code == 'email-already-in-use') {
       shows();
     }
   } catch (e) {
     print(e);
   }
 }

 static Future<UserModel?> ReadUsers(String id)
 async {
   DocumentSnapshot<UserModel>user=await getUserCollection().doc(id).get();
UserModel? userModel=user.data();
return userModel;

 }

 static Future<void> SignIn(String Email , String pass,Function notfound,Function Navi)
 async {
   try {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: Email,
         password: pass
     );
     if(credential.user!.uid !=null) {
       UserModel?  usermodel=await ReadUsers(credential.user!.uid);
       Navi(usermodel);
     }
   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       notfound();
     } else if (e.code == 'wrong-password') {
       notfound();
     }
   }
 }
}
