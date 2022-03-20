import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_finder/data.dart';
import 'package:pet_finder/pet_widget.dart';

class CategoryList extends StatelessWidget {
  final PetCategory category;

  const CategoryList({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getTitle() {
      switch (category) {
        case PetCategory.BUNNY:
          return "Bunny";
        case PetCategory.HAMSTER:
          return "Hamster";
        case PetCategory.CAT:
          return "Cat";
        case PetCategory.DOG:
          return "Dog";
        default:
          return "unknown";
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          getTitle() + " Category",
          style: TextStyle(
            color: Color(0xFF424242),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 32,
              top: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildFilter("Mating", false),
                buildFilter("Adoption", true),
                buildFilter("Disappear", true),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 1,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 0,
                  children: getPetList()
                      .where((element) => element.category == category)
                      .map((item) {
                    return PetWidget(pet: item, index: 1);
                  }).toList(),
                )),
          ),
        ],
      ),
    );
  }

  Widget buildFilter(String name, bool selected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: selected ? Colors.blue[300] : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            width: 1,
            color: selected ? Colors.transparent : Color(0xFFE0E0E0),
          ),
          boxShadow: [
            BoxShadow(
              color:
                  selected ? Color(0xFF64B5F6).withOpacity(0.5) : Colors.white,
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 0),
            )
          ]),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.grey[800],
            ),
          ),
          selected
              ? Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
