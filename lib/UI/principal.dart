import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/NetworkHandler.dart';
import 'package:flutter_app/UI/data.dart';
import 'package:flutter_app/UI/pet_widget.dart';
import 'package:flutter_app/UI/category_list.dart';
import 'package:logger/logger.dart';
import 'package:flutter_app/Pages/HomePage.dart';


class Principal extends StatefulWidget {

  Principal({Key key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  var log = Logger();

  NetworkHandler networkHandler = NetworkHandler();
  var pets = new List<Pet>();
  _getPets() {
    networkHandler.getPets().then((response) {
      setState(() {
        Iterable res =  json.decode(response.body);
        pets = res.map((model) => Pet.fromJson(model)).toList();
      });
    });
  }
  initState() {
    super.initState();
    _getPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
              child: Text(
                "It isn't lost if someone has found it.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                ),
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.all(16),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: 'Search',
            //       hintStyle: TextStyle(fontSize: 16),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: BorderSide(
            //           width: 0,
            //           style: BorderStyle.none,
            //         ),
            //       ),
            //       filled: true,
            //       fillColor: Colors.grey[100],
            //       contentPadding: EdgeInsets.only(right: 30,),
            //       prefixIcon: Padding(
            //         padding: EdgeInsets.only(right: 16.0, left: 24.0),
            //         child: Icon(
            //           Icons.search,
            //           color: Colors.black,
            //           size: 24,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Have it Back !",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPetCategory("Mobile", "56", Colors.orange[200],pets),
                      buildPetCategory("People", "210", Colors.blue[200],pets),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPetCategory("Pets", "90", Colors.green[200],pets),
                      buildPetCategory("Car", "340", Colors.red[200],pets),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Latest Posts",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),

                ],
              ),
            ),

            Container(
              height: 280,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildNewestPet(),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Association Lost&Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),

                ],
              ),
            ),

            Container(
              height: 130,
              margin: EdgeInsets.only(bottom: 16),
              child: PageView(
                physics: BouncingScrollPhysics(),
                children: [
                  buildVet("assets/images/vets/jj.png", "lost and found tunisia", "(369) 133-8956"),
                  buildVet("assets/images/vets/jjj.png", "Artemis lost Center", "(706) 722-9159"),
                  buildVet("assets/images/vets/vet_2.png", "PETS found", "(598) 4986-9532"),
                  buildVet("assets/images/vets/jjjjj.png", "l&f Center", "(33) 8974-559-555"),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildPetCategory(String category, String total, Color color,List<Pet> pets){
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryList(category: category,pets: pets)),
          );
        },
        child: Container(
          height: 80,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[200],
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [

              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.5),
                ),
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "assets/images/" + (category == "Mobile" ? "mobile" : category == "People" ? "people" : category == "Pets" ? "pets" : "car") + ".png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 12,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    category == "Mobile" ? "mobile" : category == "People" ? "people" : category == "Pets" ? "pets" : "Car",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Total of " + total,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildNewestPet(){
    List<Widget> list = [];
    for (var i = pets.length - 1 ; i >= 0; i--) {
      // if(pets[i].newest){
       list.add(
          PetWidget(
            pet: pets[i], 
            index: i
          )
        );
      // }
     }
    return list;
  }

  Widget buildVet(String imageUrl, String name, String phone){
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 1,
          color: Colors.grey[300],
        ),
      ),
      child: Row(
        children: [

          Container(
            height: 98,
            width: 98,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(
            width: 16,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                name,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 8,
              ),

              Row(
                children: [

                  Icon(
                    Icons.phone,
                    color: Colors.grey[800],
                    size: 18,
                  ),

                  SizedBox(
                    width: 8,
                  ),

                  Text(
                    phone,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),

              SizedBox(
                height: 8,
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  "OPEN - 24/7",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }

}