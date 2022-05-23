import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/ogretmen.dart';

class DataService {
  final String baseUrl = "https://6287867ce9494df61b3adab5.mockapi.io/";

  Future<Ogretmen> ogretmenIndir() async {
    // http.get ile veriyi alıyoruz.
    final response = await http.get(Uri.parse("$baseUrl/ogretmen/1"));

    if (response.statusCode == 200){
      return Ogretmen.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Öğretmen İndirilemedi. ${response.statusCode}");
    }
  }

  Future<void> ogretmenEkle(Ogretmen ogretmen) async {
    // htt.post ile veriyi gönderiyoruz.
    final response = await http.post(
      Uri.parse("$baseUrl/ogretmen"),
      headers: <String, String> {
      },
      body: jsonEncode(ogretmen.toMap()),
    );

    if (response.statusCode == 201){
      return;
    } else {
      throw Exception("Öğretmen eklenemedi. ${response.statusCode}");
    }
  }

  var i = 0;

  Future<List<Ogretmen>> ogretmenleriGetir() async {
    // http.get ile veriyi alıyoruz.
    final response = await http.get(Uri.parse("$baseUrl/ogretmen"));

    i++;
    if (response.statusCode == (i < 4 ? 100 : 200)){
      final l = jsonDecode(response.body);
      return l.map<Ogretmen>((e) => Ogretmen.fromMap(e)).toList();
    } else {
      throw Exception("Öğretmenler Getirilemedi. ${response.statusCode}");
    }
  }

}

final dataServiceProvider = Provider(
    (ref) {
      return DataService();
    }
);
