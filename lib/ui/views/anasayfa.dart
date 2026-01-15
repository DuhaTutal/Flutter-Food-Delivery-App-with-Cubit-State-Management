import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemeklerdao_repository.dart';
import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/favoriler_cubit.dart';
import 'package:bitirme_projesi/ui/views/detay_sayfa.dart';
import 'package:bitirme_projesi/ui/views/favorites.dart';
import 'package:bitirme_projesi/ui/views/sepet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFC8C9CC),
      appBar: AppBar(title: Text("Acıktım",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600),),
        backgroundColor: Color(0xFF0D90A6),),
      body: Column(
        children: [
          TextField(
            onChanged: (aramaKelimesi) {
              context.read<AnasayfaCubit>().ara(aramaKelimesi);
            },
            decoration: const InputDecoration(
              hintText: "Ara",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
                builder: (context,yemekListesi){
                  if(yemekListesi.isNotEmpty){
                    return GridView.builder(
                      itemCount: yemekListesi.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.591,),
                      itemBuilder: (context,indeks){
                        var yemek = yemekListesi[indeks];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek)));
                          },
                          child: Card(color: Color(0xFF6DA1A3),
                            child: Column(
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BlocBuilder<FavorilerCubit, List<Yemekler>>(
                                      builder: (context, favorilerListesi) {
                                        bool isFavorite = favorilerListesi.any((element) => element.yemek_adi == yemek.yemek_adi);
                                        return IconButton(
                                          onPressed: () {
                                            if (isFavorite) {
                                              context.read<FavorilerCubit>().favoriSil(yemek);
                                            } else {
                                              context.read<FavorilerCubit>().favoriyeEkle(yemek);
                                            }
                                          },
                                          icon: Icon(
                                            isFavorite ? Icons.favorite : Icons.favorite_border,
                                          ),
                                        );
                                      },
                                    )
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
                  }else{
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      )
    );
  }
}
