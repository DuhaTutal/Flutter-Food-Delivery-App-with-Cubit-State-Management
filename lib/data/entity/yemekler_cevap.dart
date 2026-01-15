import 'package:bitirme_projesi/data/entity/yemekler.dart';

class YemeklerCevap {
  List<Yemekler> yemekler;
  List<Yemekler>? sepet_yemekler;
  int success;

  YemeklerCevap({required this.yemekler, this.sepet_yemekler, required this.success});

  factory YemeklerCevap.fromJson(Map<String, dynamic> json) {
    var yemeklerListesi = json["yemekler"] != null
        ? (json["yemekler"] as List).map((i) => Yemekler.fromJson(i)).toList()
        : <Yemekler>[];

    var sepetListesi = json["sepet_yemekler"] != null
        ? (json["sepet_yemekler"] as List).map((i) => Yemekler.fromJson(i)).toList()
        : <Yemekler>[];

    return YemeklerCevap(
      yemekler: yemeklerListesi,
      sepet_yemekler: sepetListesi,
      success: json["success"] as int,
    );
  }
}