import 'dart:convert';
import 'package:flutter_ogrenciapp_02/models/ogretmen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = "https://6287867ce9494df61b3adab5.mockapi.io/";

  Future<Ogretmen> ogretmenIndir() async {
    final response = await http.get(Uri.parse("$baseUrl/ogretmen/1"));

    if (response.statusCode == 200){
      return Ogretmen.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Öğretmen İndirilemedi. ${response.statusCode}");
    }
  }

  Future<void> ogretmenEkle(Ogretmen ogretmen) async {

  }

}

final dataServiceProvider = Provider(
    (ref) {
      return DataService();
    }
);
