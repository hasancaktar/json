import 'package:json/models/model.dart';

class Araba {

  String araba_adi;
  String ulke;
  int kurulus_tarihi;
  List<Model> model;

	Araba.fromJsonMap(Map<String, dynamic> map): 
		araba_adi = map["araba_adi"],
		ulke = map["ulke"],
		kurulus_tarihi = map["kurulus_tarihi"],
		model = List<Model>.from(map["model"].map((it) => Model.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['araba_adi'] = araba_adi;
		data['ulke'] = ulke;
		data['kurulus_tarihi'] = kurulus_tarihi;
		data['model'] = model != null ? 
			this.model.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
