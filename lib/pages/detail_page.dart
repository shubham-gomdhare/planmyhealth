import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final List<String> detailingList;

  DetailPage(this.detailingList);

  @override
  Widget build(BuildContext context) {
    detailingList.insert(0, "");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Detail',
          style: TextStyle(
            fontSize: 22.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Card(
          elevation: 5.0,
          child: ListView.builder(
            itemCount: detailingList.length,
            itemBuilder: (context, pos) {
              if (pos == 0)
                return Image.asset(
                  'images/asset-1.png',
                  height: 250.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              return pos % 2 != 0
                  ? _heading(text: detailingList[pos])
                  : _matter(text: detailingList[pos]);
            },
          ),
        ),
      ),
    );
  }

  Widget _heading({@required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _matter({@required String text}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
