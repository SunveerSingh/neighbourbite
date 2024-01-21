import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudkitchen/screens/orderscreen.dart';
import 'package:cloudkitchen/screens/programs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference fooditems = FirebaseFirestore.instance
      .collection("public")
      .doc("items")
      .collection("food");

  // getList() {
  //   //returns restaurant list for public view
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: fooditems.snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('Something went wrong');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Text("Loading");
  //       }

  //       return ListView(
  //         physics: ScrollPhysics(),
  //         shrinkWrap: true,
  //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
  //           return InkWell(
  //             onTap: () {},
  //             child: Container(
  //               height: 100,
  //               margin: EdgeInsets.only(bottom: 10),
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.circular(25)),
  //                   color: Colors.amberAccent),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           document['itemName'],
  //                           style: TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.bold),
  //                         ),
  //                         Text(document['discription']),
  //                         SizedBox(
  //                           height: 5,
  //                         ),
  //                         Container(
  //                           decoration: BoxDecoration(
  //                               color: Colors.green,
  //                               borderRadius:
  //                                   BorderRadius.all(Radius.circular(8))),
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(6.0),
  //                             child: Text(
  //                               document['cuisine'],
  //                               style: TextStyle(
  //                                   color: Colors.white,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     Icon(
  //                       Icons.food_bank,
  //                       size: 62,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    //double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "See What Your Neighbors are cooking!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: screenwidth - 20,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.1,
                      0.6,
                      0.9,
                    ],
                    colors: [
                      Colors.teal,
                      Colors.teal,
                      Colors.teal,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Free Donuts Today!",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "John is providing free \ndonouts to everyone \nin the neighbourhood \nfrom 8AM - 10 AM!",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset("assets/images/donuts.png")
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProgramScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Explore More",
                      style: TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      color: Colors.teal,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Hungry? We got you!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: fooditems.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderScreen(
                                      itemName: document['itemName'],
                                      discription: document['discription'],
                                      cuisine: document['cuisine'],
                                      uid: document['uid'],
                                    )),
                          );
                        },
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Colors.amberAccent),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document['itemName'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(document['discription']),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          document['cuisine'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.food_bank,
                                  size: 62,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
