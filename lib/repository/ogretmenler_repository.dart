import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/ogretmen.dart';

class OgretmenlerRepository extends ChangeNotifier{

  List ogretmenler = [
    Ogretmen("Faruk", "Yılmaz", 18, "Erkek"),
    Ogretmen("Semiha", "Çelik", 20, "Kadın")
  ];

  void download() {
    const j = """{
      "ad" : "Ahmet",
      "soyad" : "Eskicioğlu",
      "yas" : 24,
      "cinsiyet" : "Erkek"
    }""";
    final m = jsonDecode(j);
    final ogretmen = Ogretmen.fromMap(m);
    ogretmenler.add(ogretmen);
    notifyListeners();
  }

}

final ogretmenlerProvider = ChangeNotifierProvider(
  (ref) {
    return OgretmenlerRepository();
  }
  );