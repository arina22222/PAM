import 'wine.dart';

class WineType {
  final String tag;
  final String name;

  WineType({
    required this.tag,
    required this.name,
  });

  factory WineType.fromJson(Map<String, dynamic> json) {
    return WineType(
      tag: json['tag'],
      name: json['name'],
    );
  }
}