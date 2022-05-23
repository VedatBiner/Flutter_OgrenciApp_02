// Öğrenci Uygulaması, ekran tasarımları
// API Servisi kullanımı
// http post
// http get
// Liste çekmek
// hata yaratıp, görmek

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_ogrenciapp_02/repository/ogrenciler_repository.dart';
import 'package:flutter_ogrenciapp_02/repository/ogretmenler_repository.dart';
import 'package:flutter_ogrenciapp_02/repository/mesajlar_repository.dart';
import 'package:flutter_ogrenciapp_02/pages/mesajlar_sayfasi.dart';
import 'package:flutter_ogrenciapp_02/pages/ogrenciler_sayfasi.dart';
import 'package:flutter_ogrenciapp_02/pages/ogretmenler_sayfasi.dart';

void main() {
  runApp(const ProviderScope(
      child: OgrenciApp()
  )
  );
}

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Öğrenci Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnaSayfa(title: 'Öğrenci Ana Sayfa'),
    );
  }
}

class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final ogrencilerRepository =  ref.watch(ogrencilerProvider);
    final ogretmenlerRepository =  ref.watch(ogretmenlerProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                child: Text(
                    "${ref.watch(yeniMesajSayisiProvider)} yeni mesaj"
                ),
                onPressed: (){
                  _mesajlaraGit(context);
                },
              ),
              TextButton(
                child: Text(
                    "${ogrencilerRepository.ogrenciler.length} öğrenci"
                ),
                onPressed: (){
                  _ogrencilereGit(context);
                },
              ),
              TextButton(
                child: Text(
                    "${ogretmenlerRepository.ogretmenler.length} öğretmen"
                ),
                onPressed: (){
                  _ogretmenlereGit(context);
                },
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                    "Öğrenci adı"
                ),
              ),
              ListTile(
                title: const Text(
                    "Öğrenciler"
                ),
                onTap: (){
                  _ogrencilereGit(context);
                },
              ),
              ListTile(
                title: const Text(
                    "Öğretmenler"
                ),
                onTap: (){
                  _ogretmenlereGit(context);
                },
              ),
              ListTile(
                title: const Text(
                    "Mesajlar"
                ),
                onTap: (){
                  _mesajlaraGit(context);
                },
              ),
            ],
          ),
        )
    );
  }

  void _ogrencilereGit(context) {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context){
            return const OgrencilerSayfasi();
          },
        )
    );
  }

  void _ogretmenlereGit(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context){
            return const OgretmenlerSayfasi();
          },
        )
    );
  }

  Future<void> _mesajlaraGit(context) async {
    await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context){
            return const MesajlarSayfasi();
          },
        )
    );
  }

}