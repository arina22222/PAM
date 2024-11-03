import '../../Domain/models/wine.dart';
import '../../Domain/models/wine_type.dart';

class WineResponse {
  final List<WineType> winesBy;
  final List<Wine> carousel;

  WineResponse({
    required this.winesBy,
    required this.carousel,
  });

  factory WineResponse.fromJson(Map<String, dynamic> json) {
    var winesByList = json['wines_by'] as List;
    var carouselList = json['carousel'] as List;

    return WineResponse(
      winesBy: winesByList.map((e) => WineType.fromJson(e)).toList(),
      carousel: carouselList.map((e) => Wine.fromJson(e)).toList(),
    );
  }
}
