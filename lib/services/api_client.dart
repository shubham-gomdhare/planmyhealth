import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medico/models/cart.dart';
import 'package:medico/models/diagnostic.dart';
import 'package:medico/models/doctors.dart';
import 'package:medico/models/insurance.dart';
import 'package:medico/models/medicines.dart';
import 'package:medico/models/member.dart';
import 'package:medico/models/order.dart';
import 'package:medico/models/physiotherapy_speciality.dart';
import 'package:medico/models/server_success.dart';
import 'package:medico/models/treatment_medicine.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

// http://ec2-18-216-148-49.us-east-2.compute.amazonaws.com
// http://192.168.1.4
@RestApi(baseUrl: "http://192.168.1.4:8080")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/doctors")
  Future<List<Doctor>> getDoctors();

  @GET('/medicines')
  Future<List<Medicine>> getMedicines(@Query('page') int page);

  @GET('/diagnostics')
  Future<List<Diagnostic>> getDiagnostics();

  @GET('/cart')
  Future<Cart> getCart(@Query('userId') String userId);

  @POST('/cart')
  Future<ServerSuccess> addToCart(@Body() PostCart postcart);

  @DELETE('/cart')
  Future<ServerSuccess> removeFromCart(
      @Query('userId') String userId, @Query('itemId') String itemId);

  @POST('/cart/checkout')
  Future<ServerSuccess> checkout(
      @Query('userId') String userId, @Part() File image);

  @POST('/doctors/book')
  Future<ServerSuccess> bookDoctor(@Query('userId') String userId,
      @Query('doctorId') String doctorId, @Query('bookedAt') int bookedAt);

  @POST('/healthassist/book')
  Future<ServerSuccess> bookHealthAssist(
    @Query('userId') String userId,
    @Query('id') String id,
    @Query('type') String type,
  );

  @GET('/healthassist/physiotherapyspecialities')
  Future<List<PhysiotherapySpeciality>> getPhysiotherapySpecialities();

  @GET('/healthassist/insurances')
  Future<List<Insurance>> getInsurances();

  @GET('/healthassist/treatment&medicines')
  Future<List<TreatmentMedicine>> getHospitalizationAssistance();

  @GET('/cart/orders')
  Future<List<Order>> getOrders(@Query('userId') String userId);

  @GET('/cart/appointments')
  Future<List<Order>> getDoctorAppointments(@Query('userId') String userId);

  @GET('/getmember')
  Future<Member> getMemberDetail(
      @Query('mobileNumber') String mobileNumber, @Query('email') String email);
}
