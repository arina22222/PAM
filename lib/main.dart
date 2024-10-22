import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wine Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WineShopScreen(),
    );
  }
}

class WineShopScreen extends StatefulWidget {
  @override
  _WineShopScreenState createState() => _WineShopScreenState();
}

class _WineShopScreenState extends State<WineShopScreen> {
  int selectedFilterIndex = 0;
  int? selectedSubcategoryIndex;
  String selectedLocation = 'Select Location';

  List<String> filterOptions = ['Type', 'Style', 'Countries', 'Grape'];
  Map<String, List<String>> subcategories = {
    'Type': ['Red Wine', 'White Wine', 'Rosé Wine', 'Sparkling Wine'],
    'Style': ['Sweet', 'Dry', 'Semi-Dry', 'Rich'],
    'Countries': ['Moldova', 'France', 'Italy', 'USA'],
    'Grape': ['Cabernet Sauvignon', 'Merlot', 'Chardonnay', 'Pinot Noir'],
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 310,
                    height: 65,
                    margin:
                        const EdgeInsets.only(top: 52, left: 16, bottom: 32),
                    // Top margin of 52px, left margin of 16px, bottom margin for gap
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            SizedBox(width: 8),
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
                          ],
                        ),
                        SizedBox(height: 0),
                        // Full address text below the dropdown
                        Text(
                          'Full Address: 123 Wine Street, City, Country',
                          // You can replace this with dynamic data
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Notification Button on the right side
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

              Row(
                children: [
                  // Search Bar with Microphone Icon
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

                  // Location Dropdown
                ],
              ),

              SizedBox(height: 16),

              // Shop wines by text
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
                            selectedSubcategoryIndex =
                                null; // Reset subcategory when changing filter
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

              // Subcategory Horizontal Scroll
              if (subcategories[filterOptions[selectedFilterIndex]] != null)
                SizedBox(
                  height: 150, // Height of the horizontal scroll view
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      subcategories[filterOptions[selectedFilterIndex]]!.length,
                      (index) {
                        return WineTypeCard(
                          imageUrl:
                              'https://s3-alpha-sig.figma.com/img/0bfb/9ca6/343262ac19e598febb0e6e35b1096523?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=OsTvaHpekCcIdoZ6WteK-fcVT3q~allO6BywMSn-cc5EmO-TXsbB8COSdS6up4xAEEky4fJ7APsQ4F7qYq6t6vwDhIO7W-HC31554svEEUPcA53nuCYX1dvT-iINEI5SL-tm5sd~wStJaq-vSD3IBRWfNmc5Ae6tNSTnUdbCtwogmrPsgXew9ADTEL5ejmnDjWQi8OEKyPq0qZ6VrY2lu1FrdZVHJmzDGgFLv6kJ9iMnzm7IhIwLBoMym-DZfaM8ZLZXrzzbjTDhg70sUBXW8WhMv5NzfZHFXlIP-DBMLz-0FLzvEgg8I0oYEveljl4nVngTs2qGHPmzYw--14GVGg__',
                          description: subcategories[
                              filterOptions[selectedFilterIndex]]![index],
                          isSelected: selectedSubcategoryIndex == index,
                          onTap: () {
                            setState(() {
                              selectedSubcategoryIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),

              SizedBox(height: 16),
              Text(
                'Wine',
                style: TextStyle(
                  fontFamily: 'Archivo',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 27 / 20,
                ),
              ),

              // Wine Cards Section (after selecting a subcategory)
              if (selectedSubcategoryIndex != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WineCard(
                      imageUrl:
                          'https://s3-alpha-sig.figma.com/img/e27c/5afd/28acb40a547934847b36b48af6477845?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=apPsXCJzKiQTE2EHS0gooAmsQY~bqt--xkez5LPMeFs7ukDQ87QxVpbGyaDKJ3JQisxiSWLxBRIbhDhae2JXYOIWnZDZHIJ-t58n-ytG4SwU40QUSvhtYqeJEx7sfQs2jGAZ0OYNxGahV0EzeTxTSFbolD5jamS72xFj5InXYioBRMgS4g2BnoZACo7WZPhXoTZecf~777GL6Ozip-ySRFG99EUsR-P4T94LT9lOs6q6Mw8e7vVuV4Qu0Pl3gLj5Rk-s7gscJhkpHarAW1nKwYqvimfLiDY4ohBh6knwg502Na5KNX~iiS8RpnQMpQIP8isq4pvcrHLTyvqZYxcvgw__',
                      // Correctly using named parameter
                      wineName: 'Ocone Mozzich Beneventano Bianco IGT',
                      criticScore: 94,
                      price: '23,256,598',
                      type: 'RedWine',
                      country: 'Moldova',
                      quantity: '750ml',
                    ),
                    WineCard(
                      imageUrl:
                          'https://s3-alpha-sig.figma.com/img/8513/51ad/98fec74323cca9028e128fb8a2c5eeb9?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=WFLGwOpXsoo0hnoAKu4wJB1GEd7lbwuo8hs0FNvuWZHw5tdYVktb7FxofaJImknRwNCkvmVbUSoC~mRiDz62wLFL5qwo44ON46rQWy6sfcnRLxxWfbeI5ftDlnsqes0hGibqLAcF9orWJCo6WSFd13~urs2H~1oNiEGYn5H5mDDnPCh93ONs5tQ8o37eGZ6bYZbtjVbOYACjG~8l2EOqXoAQqAUCpmeycgWYA6zECqCaNCJqQAUeHqC-vD-oWuHgU8O1LkVKipVF~OmTsIVVsGXUsLidZSdw8~QxnNzZf2-6L8nVBgy~eJQ4mraeK41gFspEQMjDwjy6u0n17OnpHw__',
                      wineName: '2021 Petit Chablis - Pasay Le Clou',
                      criticScore: 94,
                      price: '23,256,598',
                      type: 'RedWine',
                      country: 'Moldova',
                      quantity: '750ml',
                    ),
                    WineCard(
                      imageUrl:
                          'https://s3-alpha-sig.figma.com/img/a383/1b72/05bde8921b7faac424c104b681d950ac?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=fEIrvntGeGZ~xIdxEWCaoJDcY8uIoH~qKl5dBEvu2W7mSOrDYpsWx7~wWwAbRpdtHAjh7vIhjYCs8Oyc3S1hgdWxD67Hf~pdg4RExfuGpW~695109Ig9dH~FVNkcdyl43FFrn82Y0aWTAajte04r3RqUqY~pkK~rYqdWxvxoBhNCK44sDPBSKTP~64HykqaOrb50YE2t7DRViot1Bkwg3T6IBiOgLIsB00-XJhrU0jrjGKEtCuJ7H-4Ph7uiIYnEE0WP4LlLOL9wOy03rxHir9HGbVMFhomigL60g5mkRmzOVUBD34KzSdpdErkigBJFptNj5luNjHt6e02YOp0BfA__',
                      wineName:
                          'Philippe Fontaine Champagne Brut Rosé, Rosé de Saignée, NV',
                      criticScore: 94,
                      price: '23,256,596',
                      type: 'RedWine',
                      country: 'Moldova',
                      quantity: '750ml',
                    ),
                    WineCard(
                      imageUrl:
                          'https://s3-alpha-sig.figma.com/img/ca8c/e1be/69c536714e60a53a0a562074ab483d8b?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=OV7IZxTzJ2QzYCFG-3BOCXq-nqy269O-xGGo1-Ws4CTsu2QrB~3wIe5eYVss8nOkxDubJC8x9IIpiqx4lGd9QASSak479UEOduhUix2ZvTmQ424NbNP49u8FKVp7R2Xc0z7iGWkCZ5qpE45S0OkAA6vdOV0GtLOlLUVBX2IjGYkjdIMG7UdsW164m4t4LiMUPSo~2aLLTAAHa9W7cwTr4rpcZdO2Yzjaezi4132d7JntwegaFo7rDkz4rCUXeG2mU~o9lghj9PJ~07z7KjE-ik0fIRbGRuzx4UTHenlmfu-ggUN9SIyPCfjDWmnryufuVa9NARhrmn5PyJmDc46u6g__',
                      wineName: '2021 Cicada\'s Song Rosé',
                      criticScore: 94,
                      price: '23,256,596',
                      type: 'RedWine',
                      country: 'Moldova',
                      quantity: '750ml',
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class WineTypeCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  WineTypeCard({
    required this.imageUrl,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WineCard extends StatelessWidget {
  final String imageUrl;
  final String wineName;
  final int criticScore;
  final String price;
  final String type;
  final String country;
  final String quantity;

  WineCard({
    required this.imageUrl,
    required this.wineName,
    required this.criticScore,
    required this.price,
    required this.type,
    required this.country,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // White background section (Wine Details)
        Container(
          width: 343, // Fixed width to match the design
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(color: Colors.grey), // Gray border
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Ensuring consistent padding inside the white container
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wine Image
                Container(
                  width: 110,
                  height: 182, // Adjust height for a proper aspect ratio
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!), // Slight border to integrate it better
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Wine Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Wine Title
                      Text(
                        wineName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),

                      // Wine Type
                      Text(
                        ' $type',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),

                      // Country of Origin
                      Text(
                        ' $country',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Gray background section (Action Buttons, Price, Critic Score, Quantity)
        Container(
          width: 343, // Fixed width
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Padding inside the gray container
          decoration: BoxDecoration(
            color: Color(0xFFF2F4F7), // Gray background color
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border(
              top: BorderSide(color: Colors.grey.shade300), // Gray border at the top
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column with Add to Favorite Button and Critic Score
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add to favorites action
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Favourite'),
                  ),
                  SizedBox(height: 8), // Add some spacing
                  Text(
                    'Critic Score: $criticScore/100',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),

              // Price and Quantity
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ' $price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4), // Add spacing
                  Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20), // Add spacing after the card
      ],
    );
  }
}
