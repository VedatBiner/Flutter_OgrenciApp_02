import 'dart:convert';
import 'package:flutter_ogrenciapp_02/models/ogretmen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DataService {
  Ogretmen ogretmenIndir() {
    const j = """{
      "ad" : "Ahmet",
      "soyad" : "Eskicioğlu",
      "yas" : 24,
      "cinsiyet" : "Erkek"
    }""";
    final m = jsonDecode(j);
    final ogretmen = Ogretmen.fromMap(m);
    return ogretmen;
  }

}

final dataServiceProvider = Provider(
        (ref) {
      return DataService();
    }
);
