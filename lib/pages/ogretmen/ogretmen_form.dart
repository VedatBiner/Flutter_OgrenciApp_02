import 'package:flutter/material.dart';
import 'package:flutter_ogrenciapp_02/services/data_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/ogretmen.dart';

class OgretmenForm extends ConsumerStatefulWidget {
  const OgretmenForm({Key? key}) : super(key: key);

  @override
  _OgretmenFormState createState() => _OgretmenFormState();
}

class _OgretmenFormState extends ConsumerState<OgretmenForm> {
  final Map<String, dynamic> girilen = {};
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Öğretmen"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Ad"),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "Ad girmeniz gerekli";
                    }
                  },
                  onSaved: (newValue) {
                    girilen["ad"] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Soyad"),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "Soyad girmeniz gerekli";
                    }
                  },
                  onSaved: (newValue) {
                    girilen["soyad"] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Yaş"),
                  ),
                  validator: (value) {
                    if (value == null || value.isNotEmpty != true) {
                      return "Yaş girmeniz gerekli";
                    }
                    if (int.tryParse(value) == null) {
                      return "Rakamlarla yaş girmeniz gerekli !!!";
                    }
                    return null; // burası olacak mı ?
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    girilen["yas"] = int.parse(newValue!);
                  },
                ),
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      value: "Erkek",
                      child: Text("Erkek"),
                    ),
                    DropdownMenuItem(
                      value: "Kadın",
                      child: Text("Kadın"),
                    )
                  ],
                  value: girilen["cinsiyet"],
                  onChanged: (value) {
                    setState(() {
                      girilen["cinsiyet"] = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return " Lütfen cinsiyet seçiniz";
                    }
                    return null; // Burası olmalı mı ?
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    final formState = _formKey.currentState;
                    if (formState == null) return;
                    if (formState.validate() == true) {
                      formState.save();
                      print(girilen);
                    }
                    _kaydet();
                  },
                  child: const Text("Kaydet")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _kaydet() async {
    await ref.read(dataServiceProvider).ogretmenEkle(Ogretmen.fromMap(girilen));
  }
}
