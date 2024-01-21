import 'package:cloudkitchen/screens/auth/auth.dart';
import 'package:cloudkitchen/screens/splashscreen/mainscreen/mainscreen.dart';
import 'package:flutter/material.dart';

class HandleRequest extends StatefulWidget {
  final String itemName;
  final String discription;
  final String uid;
  final String cuisine;
  const HandleRequest(
      {super.key,
      required this.itemName,
      required this.discription,
      required this.uid,
      required this.cuisine});

  @override
  State<HandleRequest> createState() => _HandleRequestState();
}

class _HandleRequestState extends State<HandleRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.food_bank,
            size: 64,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                widget.cuisine,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            widget.itemName,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(widget.discription),
          ElevatedButton(
            onPressed: () {
              AuthServises().approveRequest(context, widget.itemName,
                  widget.discription, widget.cuisine, widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text("Approve"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Reject"),
          )
        ],
      ),
    );
  }
}
