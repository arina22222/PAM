import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wine_controller.dart';
import 'widgets/wine_card.dart';
import 'widgets/wine_type_card.dart';

class WineShopScreen extends StatefulWidget {
  @override
  _WineShopScreenState createState() => _WineShopScreenState();
}

class _WineShopScreenState extends State<WineShopScreen> {
  final WineController wineController = Get.put(WineController());
  String selectedLocation = 'Select Location';
  int selectedFilterIndex = 0;
  int? selectedSubcategoryIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (wineController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          final wines = wineController.wineResponse.value.carousel;
          final categories = wineController.wineResponse.value.winesBy;

          // Generate filter options and subcategories from WineType list
          final List<String> filterOptions = categories
              .map((wineType) => wineType.name)
              .toSet()
              .toList();
          final Map<String, List<String>> subcategories = {
            for (var wineType in categories)
              wineType.name: wineType.tag is List<String>
                  ? (wineType.tag as List<String>)
                  : [wineType.tag.toString()]
          };

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location selection container
                  Container(
                    width: 310,
                    height: 65,
                    margin: const EdgeInsets.only(top: 52, left: 16, bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            SizedBox(width: 10),
                            Flexible(
                              flex:1,
                              child:
                            DropdownButton<String>(
                              value: selectedLocation,
                              items: <String>[
                                'Select Location',
                                'Moldova',
                                'France',
                                'Italy',
                                'USA'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedLocation = newValue!;
                                });
                              },
                            ),
                            ),
                            SizedBox(width: 80),
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey[300]!, width: 2.0),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.notifications, color: Colors.grey[800]),
                                onPressed: () {
                                  // Handle notification click
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Full Address: 123 Wine Street, City, Country',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.mic, color: Colors.grey),
                                onPressed: () {
                                  // Handle microphone input
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Shop wines by',
                    style: TextStyle(
                      fontFamily: 'Archivo',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 27 / 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Filter Buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(filterOptions.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChoiceChip(
                            label: Text(filterOptions[index]),
                            selected: selectedFilterIndex == index,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedFilterIndex = index;
                                selectedSubcategoryIndex = null;
                              });
                            },
                            selectedColor: Color(0xFFF5DFE5),
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: selectedFilterIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 16),
                  if (subcategories[filterOptions[selectedFilterIndex]] != null)
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          subcategories[filterOptions[selectedFilterIndex]]!.length,
                              (index) {
                            return WineTypeCard(
                              tag: '${subcategories[filterOptions[selectedFilterIndex]]![index]}',
                              imageUrl: 'https://s3-alpha-sig.figma.com/img/0bfb/9ca6/343262ac19e598febb0e6e35b1096523?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=JBEiSbfN5dxjxHXw2xyzByhqvLANaCFvCbBcuBGSQR~iO6As3gyS1Tx1-uFssW769Zo95qJaZ09W0czb1JrDzECm1S0Zvx1VTxymtMgxvJ1Ukd3FxcogNjh3erFu40G8k15aQjdg3pW~KzwzUsnclOIJ-X7KNLSVTG~xbUWg4szXhveSZIxwK5-AtjyBOg2HuGX2mdm2k0-hY-f5SHyRDsaqUld9TBPJv1AHqUIbuGNyAY5cYLGakrx2LKzUA54lh7UovqQ46AOjg7fmZGkY~orZua8ngkiy7uS2zOtTf8Rbsndp4VKqQ8T0TQGHbOk6Rwk68qyG3KBDGY72EnFEEA__',
                              description: subcategories[filterOptions[selectedFilterIndex]]![index],
                              isSelected: selectedSubcategoryIndex == index,
                              onTap: () {
                                setState(() {
                                  selectedSubcategoryIndex = index;
                                });
                              },
                              name: subcategories[filterOptions[selectedFilterIndex]]![index],
                            );
                          },
                        ),
                      ),
                    ),
                  SizedBox(height: 16),
                  ...wines.map((wine) {
                    return WineCard(
                      imageUrl: wine.image,
                      wineName: wine.name,
                      criticScore: wine.criticScore,
                      price: wine.priceUsd,
                      type: wine.type,
                      country: wine.country,
                      city: wine.city,
                      bottleSize: wine.bottleSize,
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
