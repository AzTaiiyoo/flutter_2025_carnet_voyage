import 'address.dart';

class Sortie {
  final String id;
  final String name;
  final Address address;
  final DateTime date;
  final String? note;
  final double? rating;
  final String? imageUrl;

  const Sortie({
    required this.id,
    required this.name,
    required this.address,
    required this.date,
    this.note,
    this.rating,
    this.imageUrl,
  });

  factory Sortie.fromJson(Map<String, dynamic> json) {
    return Sortie(
      id: json['id'],
      name: json['name'],
      address: Address.fromJson(json['address']),
      date: DateTime.parse(json['date']),
      note: json['note'],
      rating: json['rating']?.toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address.toJson(),
      'date': date.toIso8601String(),
      'note': note,
      'rating': rating,
      'imageUrl': imageUrl,
    };
  }
}