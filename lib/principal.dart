import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_finder/category_list.dart';
import 'package:pet_finder/data.dart';
import 'package:pet_finder/pet_widget.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  List pets = getPetList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.sort,
          color: Colors.grey[800],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Find Your",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Lovely pet anywhere",
                style: TextStyle(color: Colors.grey[800], fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.only(right: 30),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 16, left: 24),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pet Category",
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
                  buildPetCategory(
                      PetCategory.HAMSTER, "56", Color(0xFFFFCC80)),
                  buildPetCategory(PetCategory.CAT, "210", Color(0xFF90CAF9)),
                  buildPetCategory(PetCategory.BUNNY, "90", Color(0xFFA5D6A7)),
                  buildPetCategory(PetCategory.DOG, "340", Color(0xFFEF9A9A)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Newest Pet",
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
                    "Vets Near You",
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
                  buildVet(
                    "assets/images/vets/vet_0.png",
                    "Animal Emergency Hospital",
                    "(369) 133-8943",
                  ),
                  buildVet(
                    "assets/images/vets/vet_1.png",
                    "Artemis Veterinary",
                    "(349) 131-4433",
                  ),
                  buildVet(
                    "assets/images/vets/vet_2.png",
                    "Big Lake Vet",
                    "(998) 194-0033",
                  ),
                  buildVet(
                    "assets/images/vets/vet_3.png",
                    "Veterinary Medit",
                    "(303) 133-8433",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPetCategory(PetCategory petCategory, String total, Color color) {
    getPetImage() {
      switch (petCategory) {
        case PetCategory.BUNNY:
          return "bunny";
        case PetCategory.HAMSTER:
          return "hamster";
        case PetCategory.CAT:
          return "cat";
        case PetCategory.DOG:
          return "dog";
        default:
          return "unknown";
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryList(category: petCategory),
          ),
        );
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFEEEEEE),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
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
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    "assets/images/" + getPetImage() + ".png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getPetImage().capitalize(),
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
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildNewestPet() {
    List<Widget> list = [];

    for (var i = 0; i < pets.length; i++) {
      if (pets[i].newest) {
        list.add(
          PetWidget(
            pet: pets[i],
            index: i,
          ),
        );
      }
    }

    return list;
  }

  Widget buildVet(String imageUrl, String name, String phone) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 1,
          color: Color(0xFFE0E0E0),
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
          const SizedBox(width: 16),
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
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(width: 8),
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
              const SizedBox(height: 8),
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
