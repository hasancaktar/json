
class Model {

  String model_adi;
  int fiyat;
  bool benzinli;

	Model.fromJsonMap(Map<String, dynamic> map): 
		model_adi = map["model_adi"],
		fiyat = map["fiyat"],
		benzinli = map["benzinli"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['model_adi'] = model_adi;
		data['fiyat'] = fiyat;
		data['benzinli'] = benzinli;
		return data;
	}
}
