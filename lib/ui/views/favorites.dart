import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/favoriler_cubit.dart';
import 'package:bitirme_projesi/ui/views/anasayfa.dart';
import 'package:bitirme_projesi/ui/views/anasayfa1.dart';
import 'package:bitirme_projesi/ui/views/detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFC8C9CC),
      appBar: AppBar(centerTitle: true,title: Text("Favoriler",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600)),
        backgroundColor: Color(0xFF0D90A6),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa1()));
        }, icon: Icon(Icons.clear)),
      ),
      body: BlocBuilder<FavorilerCubit,List<Yemekler>>(
          builder: (context,favoriListesi){
            if(favoriListesi.isNotEmpty){
              return GridView.builder(
                itemCount: favoriListesi.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.591,),
                itemBuilder: (context,indeks){
                  var yemek = favoriListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek)));
                    },
                    child: Card(color: Color(0xFF6DA1A3),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: (){

                                setState(() {
                                  context.read<FavorilerCubit>().favoriSil(yemek);
                                });
                              }, icon: Icon(Icons.favorite))
                            ],
                          ),
                          Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${yemek.yemek_adi}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xFF17103B)),),
                            ],),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${yemek.yemek_fiyat} ₺",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xFF17103B))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(onPressed: (){
                                  context.read<AnasayfaCubit>().sepeteYemekEkle(yemek.yemek_adi, yemek.yemek_resim_adi, int.parse(yemek.yemek_fiyat) ,1, "Duha");
                                }, icon: Icon(Icons.add_box_rounded)),
                              )

                            ],),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("Favorilerine hemen birşeyler ekle"));
            }
          },
      ),
    );
  }
}




