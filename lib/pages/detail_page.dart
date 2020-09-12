import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final List<String> detailingList;
  final VoidCallback book;

  DetailPage(this.detailingList, this.book);

  @override
  Widget build(BuildContext context) {
    detailingList.insert(0, "");
    if (book != null) detailingList.insert(detailingList.length, "");
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
            shrinkWrap: true,
            itemBuilder: (context, pos) {
              if (pos == 0)
                return Image.asset(
                  'images/asset-1.png',
                  height: 250.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              if (book != null && pos == detailingList.length - 1)
                return Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: RaisedButton(
                    onPressed: book,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Theme.of(context).accentColor,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 40.0, right: 45.0, top: 12, bottom: 12),
                      child: Text(
                        'Book',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
      margin: text == 'Name'
          ? EdgeInsets.only(top: 10.0, bottom: 2.0, left: 15.0, right: 15.0)
          : EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
      child: Text(
        text == null || text.isEmpty ? 'Not Available' : text,
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
        text == null || text.isEmpty ? 'Not Available' : text,
        style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
