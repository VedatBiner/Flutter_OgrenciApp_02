import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_ogrenciapp_02/services/data_service.dart';
import '../models/ogretmen.dart';

class OgretmenlerRepository extends ChangeNotifier{
  final DataService dataService;

  List<Ogretmen> ogretmenler = [
    Ogretmen("Faruk", "Yılmaz", 18, "Erkek"),
    Ogretmen("Semiha", "Çelik", 20, "Kadın")
  ];

  OgretmenlerRepository(this.dataService);

  Future<void> indir() async {
    Ogretmen ogretmen = await dataService.ogretmenIndir();
    ogretmenler.add(ogretmen);
    notifyListeners();
  }

  Future<List<Ogretmen>> hepsiniGetir() async {
    ogretmenler = await dataService.ogretmenleriGetir();
    return ogretmenler;
  }

}

final ogretmenlerProvider = ChangeNotifierProvider(
  (ref) {
    return OgretmenlerRepository(ref.watch(dataServiceProvider));
  }
);

final ogretmenListesiProvider = FutureProvider((ref) {
  return ref.watch(ogretmenlerProvider).hepsiniGetir();
});