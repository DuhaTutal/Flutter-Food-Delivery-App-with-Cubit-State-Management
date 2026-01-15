import 'dart:convert';

import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/entity/yemekler_cevap.dart';
import 'package:dio/dio.dart';

class YemeklerDaoRepository {
  List<String> yemekAdlariListesi = [];

  List<Yemekler> parseYemekler (dynamic cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }
  List<Yemekler> parseSepetYemekler(dynamic cevap) {
    Map<String, dynamic> jsonVerisi;
    if (cevap is String) {
      jsonVerisi = json.decode(cevap);
    } else {
      jsonVerisi = cevap;
    }
    return YemeklerCevap.fromJson(jsonVerisi).sepet_yemekler ?? [];
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url ="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {"yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": "Duha"
    };
    try {
      var cevap = await Dio().post(url, data: FormData.fromMap(veri));
      print("Ekleme sonucu: ${cevap.data.toString()}");
    } catch (e) {
      print("Dio Hatası: $e");
    }
  }

  Future<List<Yemekler>> sepettekiYemekleriGetir(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseSepetYemekler(cevap.data);
  }

  Future<void> sepettekiYemegiSil(String sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":sepet_yemek_id, "kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
  }

  Future<void> yemekAdiListesiOlustur() async {
    try {
      var response = await Dio().get('http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php');
      if (response.statusCode == 200) {
        List gelenVeri = response.data;
        yemekAdlariListesi = gelenVeri.map((item) => item['yemek_adi'].toString()).toList();
        print("Liste güncellendi: $yemekAdlariListesi");
      }
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }




}

