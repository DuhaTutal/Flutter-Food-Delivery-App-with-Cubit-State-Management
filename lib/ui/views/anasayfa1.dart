import 'package:bitirme_projesi/ui/views/anasayfa.dart';
import 'package:bitirme_projesi/ui/views/favorites.dart';
import 'package:bitirme_projesi/ui/views/sepet.dart';
import 'package:flutter/material.dart';

class Anasayfa1 extends StatefulWidget {
  const Anasayfa1({super.key});

  @override
  State<Anasayfa1> createState() => _Anasayfa1State();
}

class _Anasayfa1State extends State<Anasayfa1> {
  int secilenIndeks =0;
  var sayfalar=[const Anasayfa(),const Favorites(),const Sepet()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfalar[secilenIndeks],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Anasayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favoriler"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Sepet"),
        ],
        currentIndex: secilenIndeks,
        backgroundColor:  Color(0xFF0D90A6),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white38,
        onTap: (indeks){
          setState(() {
            secilenIndeks=indeks;
          });
        },
      ),

    );
  }
}

