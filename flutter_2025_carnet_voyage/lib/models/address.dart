class Address {
  final String? street;
  final String city;
  final String postcode;

  Address({
    this.street,
    required this.city,
    required this.postcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? properties = json['properties'];
    return Address(
      street: properties?['street'],
      city: properties?['city'] ?? 'Ville inconnue',
      postcode: properties?['postcode'] ?? '00000',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'postcode': postcode,
    };
  }

  @override
  String toString() {
    if(street != null && street!.isNotEmpty) {
      return '$street, $city, $postcode';
    }
    return '$city, $postcode';
  }
  factory Address.fromGeoJson(Map<String, dynamic> json) {
    final Map<String, dynamic> properties = json['properties'] ?? {};
    final String? street = properties['name'];
    final String city = properties['city'] ?? properties['municipality'] ?? 'Ville inconnue';
    final String postcode = properties['postcode'] ?? '00000';

    return Address(street: street, city: city, postcode: postcode);
  }
}