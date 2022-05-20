import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/ogretmen.dart';
import '../repository/ogretmenler_repository.dart';

class OgretmenlerSayfasi extends ConsumerWidget {
  const OgretmenlerSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              "Öğretmenler"
          )
      ),
      body: Column(
          children: [
            PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 32,
                      ),
                      child: Text(
                        "${ogretmenlerRepository.ogretmenler.length} Öğretmen"
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: OgretmenIndirmeButonu(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => OgretmenSatiri(
                  ogretmenlerRepository.ogretmenler[index],
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: ogretmenlerRepository.ogretmenler.length,
              ),
            ),
          ]
      ),
    );
  }
}

class OgretmenIndirmeButonu extends StatefulWidget {
  const OgretmenIndirmeButonu({
    Key? key,
  }) : super(key: key);

  @override
  State<OgretmenIndirmeButonu> createState() => _OgretmenIndirmeButonuState();
}

class _OgretmenIndirmeButonuState extends State<OgretmenIndirmeButonu> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return isLoading ? const CircularProgressIndicator() : IconButton(
          icon: const Icon(
              Icons.download
          ),
          onPressed: () async {
            // TODO loading
            // TODO error
            try{
              setState(() {
                isLoading = true;
              });
              await ref.read(ogretmenlerProvider).indir();
            } catch (e){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    e.toString()
                    ),
                  )
              );
            }
            finally {
              setState(() {
                isLoading = false;
              });
            }
          },
        );
      }
    );
  }
}

class OgretmenSatiri extends StatelessWidget {
  final Ogretmen ogretmen;
  const OgretmenSatiri(this.ogretmen,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "${ogretmen.ad} ${ogretmen.soyad}"
      ),
      leading: IntrinsicWidth(
        child: Center(
          child: Text(
            ogretmen.cinsiyet == "kadin" ? "🤵🏻‍♂" :"🤵🏻‍♀"
          ),
        ),
      ),
    );
  }
}

