import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetCubit extends Cubit<List<Yemekler>>{
  SepetCubit():super(<Yemekler> []);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepettekiYemekleriGetir(String kullanici_adi) async {
    try {
      var liste = await yrepo.sepettekiYemekleriGetir(kullanici_adi);
      print("Sepet başarıyla yüklendi: ${liste.length} ürün var.");
      emit(liste);
    } catch (e) {
      print("Sepet boş veya bir hata oluştu: $e");
      emit([]);
    }
  }

  Future<void> sepettekiYemegiSil(String sepet_yemek_id, String kullanici_adi) async {
   try {
     await yrepo.sepettekiYemegiSil(sepet_yemek_id, kullanici_adi);
     await sepettekiYemekleriGetir(kullanici_adi);
   } catch(e) {
     print("Sepeti silerken bir hata oluştu : $e");
   }

  }
}
