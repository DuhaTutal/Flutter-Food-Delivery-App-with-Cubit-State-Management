class Yemekler {
  String yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  String yemek_fiyat;
  //Sepet için
  String? sepet_yemek_id;
  String? yemek_siparis_adet;
  String? kullanici_adi;

  Yemekler({
    required this.yemek_id,
    required this.yemek_adi,
    required this.yemek_resim_adi,
    required this.yemek_fiyat,
    this.sepet_yemek_id,
    this.yemek_siparis_adet,
    this.kullanici_adi,
  });

  factory Yemekler.fromJson(Map<String, dynamic> json) {
    return Yemekler(
      yemek_id: json["yemek_id"]?.toString() ?? "",
      yemek_adi: json["yemek_adi"]?.toString() ?? "",
      yemek_resim_adi: json["yemek_resim_adi"]?.toString() ?? "",
      yemek_fiyat: json["yemek_fiyat"]?.toString() ?? "",
      // Sepet verileri
      sepet_yemek_id: json["sepet_yemek_id"]?.toString() ?? "",
      yemek_siparis_adet: json["yemek_siparis_adet"]?.toString() ?? "",
      kullanici_adi: json["kullanici_adi"]?.toString() ?? "",
    );
  }

}