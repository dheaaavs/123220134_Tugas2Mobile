import 'package:flutter/material.dart';
import 'package:tugas2/models/cats.dart';
import 'package:tugas2/pages/cat_detail_page.dart';

class CatListPage extends StatelessWidget {
  const CatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], // Warna latar belakang soft pink
      //judul diatas
      appBar: AppBar(
        title: Text(
          "🐾 Find Your Cute Cat 🐾",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true, //biar ditengah gituu anjay
        backgroundColor: Colors.pinkAccent, // Warna pastel untuk AppBar
        elevation: 4, //buat efek shadow gitu biar kek bagus aja
        shadowColor: Colors.pink.shade100, //kita beri warna pinky
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => _catStore(context, index),
          itemCount: catList.length,
        ),
      ),
    );
  }

  Widget _catStore(BuildContext context, int index) {
    final cat = catList[index];
    //umur kucing
    int age = DateTime.now().year - cat.birthday.year;
    if (DateTime.now().month < cat.birthday.month ||
        (DateTime.now().month == cat.birthday.month && DateTime.now().day < cat.birthday.day)) {
      age--;
    }

    //sex nya apa biar tauu
    String sexDisplay = cat.sex == "F" ? "Female" : "Male";
    Color sexColor = cat.sex == "F" ? Colors.pinkAccent : Colors.blueAccent;

    return GestureDetector(
      //biar dipencet ke halaman detail gt
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailPage(index: index)), //bawa index ke halaman detail
        );
      },
      //biar bentuk kartu gt
      child: Card(
        elevation: 6, //shadow warna pink
        shadowColor: Colors.pink.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), //cardnya ber border radius gitu
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, //biar posisi di tengah
          children: [
            ClipRRect( //ClipRRect buat motong gambarnya gt sesuai dgn radius
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              child: Stack( //buat numpuk gitu (jadi si iconnya itu numpuk di gambar gais)
                children: [
                  //GAMBAR KUCING
                  Image.network(
                    cat.pictureUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    //buat posisi container buletan jenis kelamin
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white, //warna putih
                        shape: BoxShape.circle, //bulat
                      ),
                      child: Icon(
                        cat.sex == "F" ? Icons.female : Icons.male,
                        color: sexColor,
                        size: 20,
                      ),
                    ),
                  )
                ]
              )
            ),

            //identitas kucing
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, //posisi ditengah kolomnya
                children: [
                  //NAMA
                  Text(
                    cat.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ComicSansMS',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),

                  //UMUR
                  Text(
                    "$age years old",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 6),

                  //JENIS KELAMIN
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      sexDisplay,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: sexColor, //sesuai dengan sexnya
                      ),
                    ),
                  ),
                  SizedBox(height: 6),

                  //Ras
                  Text(
                    cat.breed,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
