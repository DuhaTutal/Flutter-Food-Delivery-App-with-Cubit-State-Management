import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfaCubit extends Cubit{
  DetaySayfaCubit():super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    await yrepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
}