import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ogrenciapp_02/services/data_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/ogretmen.dart';

class OgretmenlerRepository extends ChangeNotifier{
  final DataService dataService;

  List ogretmenler = [
    Ogretmen("Faruk", "Yılmaz", 18, "Erkek"),
    Ogretmen("Semiha", "Çelik", 20, "Kadın")
  ];

  OgretmenlerRepository(this.dataService);

  void indir() {
    Ogretmen ogretmen = dataService.ogretmenIndir();
    ogretmenler.add(ogretmen);
    notifyListeners();
  }

}

final ogretmenlerProvider = ChangeNotifierProvider(
  (ref) {
    return OgretmenlerRepository(ref.watch(dataServiceProvider));
  }
);