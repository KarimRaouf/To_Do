import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(Icons.menu),
        title: Text(
          'First App',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {
              print('CLICKED');
            },
          ),
          IconButton(
            icon: Text('Kem'),
            onPressed: () {
              print("PRESSED");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20.0),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_960_720.jpg"),
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 200.0,
                    color: Colors.black.withOpacity(0.7),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Text(
                      "Flower",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
