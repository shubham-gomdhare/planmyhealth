import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medico/blocs/shop_bloc.dart';
import 'package:medico/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'order_success_page.dart';

class PrescriptionUploadPage extends StatefulWidget {
  final ShopBloc bloc;
  final User user;
  PrescriptionUploadPage({@required this.bloc, @required this.user, Key key})
      : super(key: key);

  @override
  _PrescriptionUploadPageState createState() => _PrescriptionUploadPageState();
}

class _PrescriptionUploadPageState extends State<PrescriptionUploadPage> {
  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: this.widget.bloc.inAsyncCall,
        initialData: false,
        builder: (context, snapshot) {
          return ModalProgressHUD(
            inAsyncCall: snapshot.data,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Upload Prescription',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                backgroundColor: Theme.of(context).accentColor,
              ),
              body: Stack(
                children: [
                  Center(
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5,
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () => getImage(ImageSource.camera),
                              child: Text(
                                'Camera',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5,
                                    color: Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () => getImage(ImageSource.gallery),
                              child: Text(
                                'Gallery',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5,
                                    color: _image == null
                                        ? Colors.grey
                                        : Theme.of(context).accentColor),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: _image == null
                                  ? null
                                  : () {
                                      this.widget.bloc.checkout(
                                          this.widget.user.uid, _image,
                                          (message) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                OrderSuccessPage(message),
                                          ),
                                        );
                                      });
                                    },
                              child: Text(
                                'Book',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: _image == null
                                      ? Colors.grey
                                      : Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
