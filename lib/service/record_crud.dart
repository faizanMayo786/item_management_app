import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../model/record.dart';
import 'server.dart';

class RecordCRUD {
  static addRecord(Record record) async {
    try {
      Map<String, dynamic> body = {
        'id': record.id,
        'name': record.name,
        'address': record.address,
        'amount': record.amount,
        'contactNo': record.contactNo,
        'date': record.date,
        'item': record.item,
        'quantity': record.quantity,
        'remaining': record.remaining,
      };
      var response = await Dio()
          .post('${server}addrecord.php', data: FormData.fromMap(body));

      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static updateRecord(Record record) async {
    try {
      Map<String, dynamic> body = {
        'id': record.id,
        'name': record.name,
        'address': record.address,
        'amount': record.amount,
        'contactNo': record.contactNo,
        'date': record.date,
        'item': record.item,
        'quantity': record.quantity,
        'remaining': record.remaining,
      };
      var response = await Dio()
          .post('${server}updaterecord.php', data: FormData.fromMap(body));
      // print(response);

      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static readRecord() async {
    try {
      Response response = await Dio().get('${server}readrecord.php');

      var data = jsonDecode(response.data);
      return data;
    } catch (e) {
      // print(e.toString());
    }
  }

  static deleteRecord(String id) async {
    try {
      Map<String, dynamic> body = {
        'id': id,
      };
      var response = await Dio()
          .post('${server}deleterecord.php', data: FormData.fromMap(body));
      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
