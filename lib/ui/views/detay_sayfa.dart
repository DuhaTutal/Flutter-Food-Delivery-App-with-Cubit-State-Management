import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/detay_sayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/favoriler_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;
  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int adet = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFC8C9CC),
      appBar: AppBar(title: Text("${widget.yemek.yemek_adi}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600),),
        backgroundColor: Color(0xFF0D90A6),
        actions: [
          BlocBuilder<FavorilerCubit, List<Yemekler>>(
            builder: (context, favorilerListesi) {
              bool isFavorite = favorilerListesi.any((element) => element.yemek_adi == widget.yemek.yemek_adi);
              return IconButton(
                onPressed: () {
                  if (isFavorite) {
                    context.read<FavorilerCubit>().favoriSil(widget.yemek);
                  } else {
                    context.read<FavorilerCubit>().favoriyeEkle(widget.yemek);
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
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
              SizedBox(height: 15,),
              Text("${widget.yemek.yemek_adi}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Color(0xFF17103B)),),
              SizedBox(height: 20,),
              Text("${widget.yemek.yemek_fiyat} ₺",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Color(0xFF17103B))),
              SizedBox(height: 20,),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      adet-=1;
                    });
                  }, icon: Icon(Icons.remove_circle_sharp),iconSize: 40,),
                  Text("$adet",style: TextStyle(fontSize: 40,),),
                  IconButton(onPressed: (){
                    setState(() {
                      adet+=1;
                    });
                  }, icon: Icon(Icons.add_circle_sharp),iconSize: 40)
                ],),

              Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("${adet*int.parse(widget.yemek.yemek_fiyat)} ₺",style: TextStyle(fontSize: 30),),
                ElevatedButton(onPressed: (){
                  context.read<DetaySayfaCubit>().sepeteYemekEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, int.parse(widget.yemek.yemek_fiyat) ,adet, "Duha");
                }, child: Text("Sepete Ekle"),style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFC1C700),foregroundColor: Colors.black),)
              ],),
            )
          ],
        ),
      ),
    );
  }
}
