import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../service/record_crud.dart';

import '../model/record.dart';

class RecordController extends GetxController {
  List<Record> record = <Record>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchRecord();
  }

  fetchRecord() async {
    // record = [];
    List<dynamic> recordsMap = await RecordCRUD.readRecord();
    List<Record> listItem = recordsMap.map((singleRecord) {
      return Record(
        id: singleRecord['id'].toString(),
        name: singleRecord['name'].toString(),
        address: singleRecord['address'].toString(),
        amount: double.parse(singleRecord['amount'].toString()),
        contactNo: singleRecord['phone_number'].toString(),
        date: singleRecord['date'] != ''
            ? DateFormat("yyyy-MM-dd").parse(singleRecord['date'])
            : DateTime.now(),
        item: singleRecord['item'].toString(),
        quantity: int.parse(singleRecord['quantity']),
        remaining: double.parse(singleRecord['remaining']),
      );
    }).toList();
    record.clear();
    record.addAll(listItem);
  }

  deleteRecord(String id) async {
    var res = await RecordCRUD.deleteRecord(id);
    if (res.toString() == 'success' && res.statusCode == 200) {
      // record.removeWhere(((element) => element.id == id));
      return true;
    }
    return false;
  }

  addRecord(Record rec) async {
    var res = await RecordCRUD.addRecord(rec);
    if (res.toString() == 'success' && res.statusCode == 200) {
      record.add(rec);
      return true;
    }
    return false;
  }

  updateRecord(Record rec) async {
    var res = await RecordCRUD.updateRecord(rec);
    if (res.toString() == 'success' && res.statusCode == 200) {
      int index = record.indexWhere((element) => element.id == rec.id);
      record[index] = rec;
      return true;
    }
    return false;
  }
}
