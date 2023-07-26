import 'package:flutter/material.dart';

class HomeSceren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: (Icon(Icons.menu)),
        title: (Text('AppBar')),
        actions: [
          IconButton(
              onPressed: () {
                print('on clicked');
              },
              icon: Icon(Icons.notification_important_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                      image: NetworkImage(
                          'https://thumbs.dreamstime.com/b/purple-flower-2212075.jpg'),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        'Flower',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
