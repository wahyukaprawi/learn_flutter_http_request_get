import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpProvider with ChangeNotifier {
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  int get jumlahData => _data.length;

  late Uri url;

  void connectAPI(String id, BuildContext context) async {
    url = Uri.parse("https://reqres.in/api/users/$id");

    var hasilResponse = await http.get(url);

    if (hasilResponse.statusCode == 200) {
      _data = (jsonDecode(hasilResponse.body))["data"];
      notifyListeners();
      // ignore: use_build_context_synchronously
      statusCodeData(context, "Berhasil mengambil data");
    } else if (hasilResponse.statusCode == 404) {
      // ignore: use_build_context_synchronously
      statusCodeData(context, "Gagal mengambil data");
    }
  }

  void deleteData(BuildContext context) async {
    var hasilResponse = await http.delete(url);

    if (hasilResponse.statusCode == 204) {
      _data = {};
      notifyListeners();
      // ignore: use_build_context_synchronously
      statusCodeData(context, "Data Terhapus");
    } 
  }

  statusCodeData(BuildContext context, String messege) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(messege),
      duration: const Duration(milliseconds: 700),
    ));
  }
}
