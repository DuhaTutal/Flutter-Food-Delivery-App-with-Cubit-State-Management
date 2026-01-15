import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/data/entity/yemekler.dart';

class FavorilerCubit extends Cubit<List<Yemekler>> {
  FavorilerCubit() : super([]);

  void favoriyeEkle (Yemekler yemek) {
    var mevcutListe = List<Yemekler>.from(state);
      mevcutListe.add(yemek);
      emit(mevcutListe);
  }

  void favoriSil (Yemekler yemek) {
    var mevcutListe = List<Yemekler>.from(state);
    mevcutListe.removeWhere((element) => element.yemek_adi == yemek.yemek_adi);
    emit(mevcutListe);
  }
}


