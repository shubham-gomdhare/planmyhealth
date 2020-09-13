import 'package:flutter/material.dart';
import 'package:medico/blocs/doctors.bloc.dart';
import 'package:medico/models/doctors.dart';
import 'package:medico/pages/docotr_acount.dart';
import 'package:medico/services/auth.dart';

class DoctorsCardWidget extends StatelessWidget {
  final Doctor doctor;
  final DoctorBloc bloc;
  final User user;
  const DoctorsCardWidget({this.doctor, this.bloc, this.user});

  @override
  Widget build(BuildContext context) {
    var isOpen = true;
    return Container(
      height: 150.0,
      padding: const EdgeInsets.all(6.0),
      child: FlatButton(
        highlightColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DoctorAcount(bloc, doctor, user)));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Card(
          elevation: 0.2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: Offset(0, 4),
                    blurRadius: 10)
              ],
            ),
            padding: const EdgeInsets.only(
                top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ball(isOpen ? "images/doctor-3.jpg" : "images/doctor-5.jpg",
                        Colors.transparent),
                    Text(
                      isOpen ? 'Open Today' : 'Closed Today',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: isOpen ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            '${doctor.name}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 160.0,
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${doctor.qualification} ${doctor.experience} years of experience',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${doctor.fromTime} - ${doctor.toTime}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        ),
      ),
    );
  }
}
