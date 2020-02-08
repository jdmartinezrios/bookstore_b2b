import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 32.0, left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.16),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 8.0,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
