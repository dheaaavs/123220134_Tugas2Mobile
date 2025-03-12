import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas2/models/cats.dart';

class DetailPage extends StatefulWidget {
  //bawa index dari list kuchengg
  final int index;
  const DetailPage({super.key, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //buat si love"
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final cat = catList[widget.index];

    //buat sex
    String sexDisplay = cat.sex == "F" ? "Female" : "Male";
    Color sexColor = cat.sex == "F" ? Colors.pinkAccent : Colors.blueAccent;

    // Menghitung umur dengan tahun dan bulan
    DateTime now = DateTime.now();
    int years = now.year - cat.birthday.year;
    int months = now.month - cat.birthday.month;
    if (now.day < cat.birthday.day) {
      months--;
    }
    if (months < 0) {
      years--;
      months += 12;
    }
    //format tahun dan bulan
    String ageText = "$years years $months months";

    // Format tanggal lahir tanpa jam
    String birthdayText = DateFormat('dd MMMM yyyy').format(cat.birthday);

    return Scaffold(
      backgroundColor: Colors.pink[50],
      //judul
      appBar: AppBar(
        title: Text(
          "🐾 Cat Details 🐾",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true, //biarjudulnya ditengah
        backgroundColor: Colors.lightBlueAccent.shade100,
        elevation: 4, //shadow
        shadowColor: Colors.pink.shade50,
        actions: [
          //icon button love love
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gambar kucing di radiusin
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              child: Image.network(
                cat.pictureUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Nama Kucing
                  Text(
                    cat.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),

                  // RAS
                  Row(
                    children: [
                      Icon(Icons.pets, color: Colors.blueGrey),
                      SizedBox(width: 8),
                      Text("Breed: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(catList[widget.index].breed),
                    ],
                  ),

                  //BIRTHDAY
                  Row(
                    children: [
                      Icon(Icons.cake, color: Colors.pinkAccent),
                      SizedBox(width: 8),
                      Text("Birthday: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(birthdayText),
                    ],
                  ),

                  //AGE
                  Row(
                    children: [
                      Icon(Icons.cake_outlined, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("Age: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(ageText), // Format tahun bulan
                    ],
                  ),

                  //COLOR
                  Row(
                    children: [
                      Icon(Icons.color_lens, color: Colors.purple),
                      SizedBox(width: 8),
                      Text("Color: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(catList[widget.index].color),
                    ],
                  ),

                  //SEX
                  Row(
                    children: [
                      Icon(Icons.wc, color: sexColor),
                      SizedBox(width: 8),
                      Text("Sex: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(sexDisplay, style: TextStyle(color: sexColor)),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Vaksinasi
                  Row(
                    children: [
                      Icon(Icons.medical_services, color: Colors.teal),
                      SizedBox(width: 8),
                      Text("Vaccines:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ],
                  ),
                  //isi vaksin apa saja dibentuk kotak" gitu
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8, //horizontal
                    runSpacing: 8, //vertikal
                    children: catList[widget.index].vaccines.map((vaccine) {  //isi isi vaksinnya
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black54),
                        ),
                        child: Text(vaccine, style: TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),

                  // Karakteristik
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("Characteristics:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ],
                  ),
                  //isi karakteristik
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: catList[widget.index].characteristics.map((char) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black54),
                        ),
                        child: Text(char, style: TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),

                  // Background
                  Row(
                    children: [
                      Icon(Icons.history, color: Colors.brown),
                      SizedBox(width: 8),
                      Text("Background:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    catList[widget.index].background,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}