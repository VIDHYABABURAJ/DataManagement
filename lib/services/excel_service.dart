import 'dart:io';

import 'package:excel/excel.dart';

class ExcelService{
  Future<List<Map<String, String>>> parseExcel(File file) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<Map<String, String>> locations = [];

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {

        locations.add({
          'country': row[0]?.value.toString()?? '',
          'state': row[1]?.value.toString() ?? '',
          'district': row[2]?.value.toString() ?? '',
          'city': row[3]?.value.toString() ?? '',
        });
      }
    }

    return locations;
  }
}