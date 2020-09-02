import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:medico/blocs/doctors.bloc.dart';
import 'package:medico/models/doctors.dart';
import 'package:medico/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'order_success_page.dart';

class DoctorBookSecondeStep extends StatelessWidget {
  final DoctorBloc bloc;
  final Doctor doctor;
  final User user;
  DoctorBookSecondeStep(this.bloc, this.doctor, this.user);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc.inAsyncCall,
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
                backgroundColor: Theme.of(context).accentColor,
                title: Text(
                  'Select a time slot',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 40,
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, bottom: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 20.0, right: 12.0, left: 12.0, bottom: 12.0),
                          margin: EdgeInsets.only(
                              right: 12.0, left: 12.0, bottom: 12.0, top: 0),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ball(
                                      'images/asset-1.png', Colors.transparent),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        doctor.name,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          doctor.qualification,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                                child: Center(
                                  child: Container(
                                    height: 2.0,
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "DATE & Time",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          DateFormat('d EEE h:mm a')
                                              .format(bloc.bookedDateTime),
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 60.0,
                                      width: 2,
                                      child: Center(
                                        child: Container(
                                          height: 60.0,
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Consultation Fees",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          "600\$",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                                child: Center(
                                  child: Container(
                                    height: 2.0,
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      margin: const EdgeInsets.only(top: 12.0),
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5,
                                            color: Color(0xdddddddd)),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color:
                                            Colors.grey[100].withOpacity(0.4),
                                      ),
                                      child: FormBuilderTextField(
                                        attribute: "Full Name",
                                        initialValue: '', //for testing
                                        decoration: InputDecoration(
                                          hintText: "Name",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          border: InputBorder.none,
                                        ),

                                        validators: [
                                          FormBuilderValidators.max(70),
                                          FormBuilderValidators.required(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50.0,
                                      margin: const EdgeInsets.only(top: 12.0),
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5,
                                            color: Color(0xdddddddd)),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color:
                                            Colors.grey[100].withOpacity(0.4),
                                      ),
                                      child: FormBuilderTextField(
                                        attribute: "Email",
                                        initialValue: '', //for testing
                                        decoration: InputDecoration(
                                          hintText: "E-mail",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          border: InputBorder.none,
                                        ),

                                        validators: [
                                          FormBuilderValidators.max(70),
                                          FormBuilderValidators.required(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50.0,
                                      margin: const EdgeInsets.only(top: 12.0),
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5,
                                            color: Color(0xdddddddd)),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color:
                                            Colors.grey[100].withOpacity(0.4),
                                      ),
                                      child: FormBuilderTextField(
                                        attribute: "phone Number",
                                        initialValue: '', //for testing
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Phone Number",
                                          hintStyle:
                                              TextStyle(fontFamily: 'Poppins'),
                                          prefixText: "+",
                                        ),
                                        keyboardType: TextInputType.number,
                                        validators: [
                                          //FormBuilderValidators.numeric(),
                                          FormBuilderValidators.required(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                child: Text(
                                  "By Booking this appointment you agree to the T&C",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0,
                color: Colors.transparent,
                child: Container(
                    padding: EdgeInsets.only(
                        right: 0.0, left: 50.0, bottom: 0.0, top: 0),
                    margin: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.6)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Give Feedback',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        RaisedButton(
                          elevation: 0,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            bloc.bookDoctor(
                                userId: user.uid,
                                doctorId: doctor.mongoId,
                                onCheckoutCompleted: (message) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OrderSuccessPage(message),
                                    ),
                                  );
                                });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: Theme.of(context).accentColor,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 55.0, right: 55.0, top: 12, bottom: 12),
                            child: Text(
                              'Book',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          );
        });
  }

  Widget ball(String image, Color color) {
    return Container(
      height: 60,
      width: 60.0,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          )),
    );
  }
}
