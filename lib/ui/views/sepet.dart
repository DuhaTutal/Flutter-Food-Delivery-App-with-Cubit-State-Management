import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_cubit.dart';
import 'package:bitirme_projesi/ui/views/anasayfa.dart';
import 'package:bitirme_projesi/ui/views/anasayfa1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sepet extends StatefulWidget {
  const Sepet({super.key});

  @override
  State<Sepet> createState() => _SepetState();
}

class _SepetState extends State<Sepet> {
  int toplamTutariHesapla(List<Yemekler> liste) {
    int toplam = 0;
    for (var yemek in liste) {
      int fiyat = int.parse(yemek.yemek_fiyat.toString());
      int adet = int.parse(yemek.yemek_siparis_adet.toString());
      toplam += (fiyat * adet);
    }
    return toplam;
  }
  @override
  void initState() {
    super.initState();
    context.read<SepetCubit>().sepettekiYemekleriGetir("Duha");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFC8C9CC),
      appBar: AppBar(centerTitle: true,title: Text("Sepet",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600)),backgroundColor: Color(0xFF0D90A6),
      leading: IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa1()));
      }, icon: Icon(Icons.clear)),
    ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SepetCubit,List<Yemekler>>(
              builder: (context,yemeklerListesi){
                if(yemeklerListesi.isNotEmpty){
                  return ListView.builder(
                      itemCount: yemeklerListesi.length,
                      itemBuilder: (context,indeks){
                        var yemek = yemeklerListesi[indeks];
                        return Card(color: Color(0xFF6DA1A3),
                          child: Row(
                            children: [
                              SizedBox(width: 110,height: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 4,top: 0 ,bottom: 0),
                                child: SizedBox(height: 110,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("${yemek.yemek_adi}",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF17103B)),),
                                      Text("Fiyat: ${yemek.yemek_fiyat} ₺",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF17103B))),
                                      Text("Adet: ${yemek.yemek_siparis_adet}",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF17103B)))
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              SizedBox(height: 110,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(onPressed: (){
                                        context.read<SepetCubit>().sepettekiYemegiSil(yemek.sepet_yemek_id.toString(),"Duha");
                                      }, icon: Icon(Icons.delete)),
                                      Text("₺${(int.parse(yemek.yemek_fiyat.toString()) * int.parse(yemek.yemek_siparis_adet.toString()))}")
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  );
                }else{
                  return Center(
                    child: Text("Sepet Boş"),
                  );
                }
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Gönderim ücreti",style: TextStyle(fontSize: 12),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("₺0",style: TextStyle(fontSize: 12),),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Toplam:",style: TextStyle(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<SepetCubit,List<Yemekler>>(
                builder: (context,yemeklerListesi){
                  int toplam = toplamTutariHesapla(yemeklerListesi);
                  return Text("₺$toplam",style: TextStyle(fontSize: 20),);
                }

              ),
            ),
          ],),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(width: 350,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC1C700),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text("Sepeti Onayla", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          )

        ],
      )

    );
  }
}
