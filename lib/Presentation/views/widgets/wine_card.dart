import 'package:flutter/material.dart';

class WineCard extends StatelessWidget {
  final String imageUrl;
  final String wineName;
  final int criticScore;
  final String bottleSize;
  final double price;
  final String type;
  final String country;
  final String city;

  WineCard({
    required this.wineName,
    required this.imageUrl,
    required this.criticScore,
    required this.bottleSize,
    required this.price,
    required this.type,
    required this.country,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // White background section (Wine Details)
        Container(
          width: 360, // Fixed width to match the design
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(color: Colors.grey), // Gray border
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                        'Type: $type',
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
                        'Country: $country',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),

                      // City
                      Text(
                        'City: $city',
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
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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

              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4), // Add spacing
                  Text(
                    'Bottle Size: $bottleSize',
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
