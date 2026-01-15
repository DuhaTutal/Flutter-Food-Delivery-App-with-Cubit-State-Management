import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit():  super(<Yemekler>[]);
  
  var yrepo = YemeklerDaoRepository();
  List<Yemekler> tumListeYedek = [];
  
  Future<void> yemekleriYukle() async {
    var liste = await yrepo.yemekleriYukle();
    tumListeYedek = liste;
    emit(liste);
  }
  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    await yrepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
  Future<List<String>> yemekAdiListesiOlustur() async {
    return await yrepo.yemekAdlariListesi;
  }

  Future<void> ara(String aramaKelimesi) async {
    if (aramaKelimesi.isEmpty) {
      emit(tumListeYedek);
    } else {
      var filtreliListe = tumListeYedek.where((yemek) {
        return yemek.yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase());
      }).toList();
      emit(filtreliListe);
    }
  }
}