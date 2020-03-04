import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:json/models/Araba.dart';

void main() => runApp(MyApp());

class Ogrenci{
  String id;
  String adi;
  Ogrenci(this.adi,this.id); 
  @override
  String toString() {
    // TODO: implement toString
    return "Adı : $adi id : $id";
  }
  factory Ogrenci.mapiNesneyeDonustur(Map<String, dynamic>gelenMap){
    return Ogrenci(gelenMap["id"],gelenMap["adi"]);
  }

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
Ogrenci emre=new Ogrenci("Emre", 10);
debugPrint(emre.toString());
Map<String, dynamic> hasanMap={"id": 15, "isim" : "Hasan"};
debugPrint("Adı : "+hasanMap["isim"]+ " id :"+hasanMap["id"].toString());

Ogrenci yeni=Ogrenci.mapiNesneyeDonustur(hasanMap);
debugPrint(yeni.toString());


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: UsingJson(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class UsingJson extends StatefulWidget {
  @override
  _UsingJsonState createState() => _UsingJsonState();
}

class _UsingJsonState extends State<UsingJson> {
  List<Araba> tumArabalar;

  @override
  void initState() {
    super.initState();
   /* debugPrint("initstate çalıştı");
    veriKaynaginiOku().then((gelenArabaListesi) {
      setState(() {
        tumArabalar = gelenArabaListesi;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build çalıştı");
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Json"),
      ),
      body: Container(
        child: FutureBuilder(
            future: veriKaynaginiOku(),
            builder: (context, sonuc) {
              if (sonuc.hasData) {
                tumArabalar = sonuc.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tumArabalar[index].araba_adi),
                      subtitle: Text(tumArabalar[index].ulke),
                    );
                  },
                  itemCount: tumArabalar.length,
                );
              } else{
                return Center(child: CircularProgressIndicator(),);
              }
            }),
      ),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    debugPrint("build çalıştı");
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Json"),
      ),
      body: tumArabalar != null ? Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tumArabalar[index]["araba_adi"]),
              subtitle: Text(tumArabalar[index]["ulke"]),
            );
          },
          itemCount: tumArabalar.length,),
      ): Center(child: CircularProgressIndicator(),)
    );
  }*/

  Future<List<Araba>> veriKaynaginiOku() async {
    /* Future<String> jsonOku =
        DefaultAssetBundle.of(context).loadString("assets/araba/araba.json");
    jsonOku.then((okunanJson) {
      debugPrint(okunanJson);
      return okunanJson;
    });*/
    var gelenJson = await DefaultAssetBundle.of(context)
        .loadString("assets/araba/araba.json");
    debugPrint(gelenJson);

    List<Araba> arabaListesi = (json.decode(gelenJson)as List).map((mapYapisi)=>Araba.fromJsonMap(mapYapisi)).toList();
    debugPrint("toplam araba: " + arabaListesi.length.toString());
    for (int i = 0; i < arabaListesi.length - 1; i++) {
      debugPrint("marka" + arabaListesi[i].araba_adi.toString());
      debugPrint("Ülke: " + arabaListesi[i].ulke.toString());
    }
    return arabaListesi;
  }
}
