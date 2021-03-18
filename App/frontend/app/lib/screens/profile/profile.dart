import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final fName;
  final lName;
  final description;

  const Profile({
    Key key,
    this.fName = "Carl",
    this.lName = "Johnson",
    this.description = "AH S@!T HERE WE GO AGAIN!",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile page'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.grey[400],
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")))),
                Container(
                  child: Text(
                    "First name: " + fName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                ),
                Container(
                    child: Text(
                      "Last name: " + lName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Text("Description: " + description),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
        child: Text('click'),
      ),
    );
  }
}
