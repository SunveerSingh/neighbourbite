import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudkitchen/screens/auth/loginscreen.dart';
import 'package:cloudkitchen/screens/splashscreen/mainscreen/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServises {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  signIn(context, email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  singUp(context, name, email, password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      FirebaseFirestore.instance
          .collection("Details")
          .doc(email)
          .collection("UserDetails")
          .add({
        'name': name,
        'email': email,
        'UID': FirebaseAuth.instance.currentUser!.uid
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  singout(context) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  addItem(context, itemName, discription, cuisine) {
    FirebaseFirestore.instance
        .collection("public")
        .doc("items")
        .collection("food")
        .add({
      'itemName': itemName,
      'discription': discription,
      'cuisine': cuisine,
      'uid': FirebaseAuth.instance.currentUser!.uid
    });
    FirebaseFirestore.instance
        .collection("private")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("food")
        .add({
      'itemName': itemName,
      'discription': discription,
      'cuisine': cuisine,
      'uid': FirebaseAuth.instance.currentUser!.uid
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Item Added')));
  }

  sendResquest(context, itemName, discription, cuisine, receiverUID) {
    FirebaseFirestore.instance
        .collection("private")
        .doc(receiverUID)
        .collection("food")
        .doc("requests")
        .collection("received")
        .add({
      'itemName': itemName,
      'discription': discription,
      'cuisine': cuisine,
      'uid': FirebaseAuth.instance.currentUser!.uid
    });
    FirebaseFirestore.instance
        .collection("private")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("food")
        .doc("requests")
        .collection("sent")
        .add({
      'itemName': itemName,
      'discription': discription,
      'cuisine': cuisine,
      'uid': receiverUID
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Request Send')));
  }

  approveRequest(context, itemName, discription, cuisine, receiverUID) {
    FirebaseFirestore.instance
        .collection("private")
        .doc(receiverUID)
        .collection("food")
        .doc("requests")
        .collection("approved")
        .add({
      'itemName': itemName,
      'discription': discription,
      'cuisine': cuisine,
      'uid': FirebaseAuth.instance.currentUser!.uid
    });
    FirebaseFirestore.instance
        .collection("private")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("food")
        .doc("requests")
        .collection("received")
        .get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        } as FutureOr Function(QuerySnapshot<Map<String, dynamic>> value));
  }
}
