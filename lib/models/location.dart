class Locations {
  final String id;
  final String? name;
  final String? description;
  final double rating;
  final int ratingCount;
  final int viewCount;
  final String? username;
  final String? openingHoursDay;
  final String? imageUrl;
  final String? locationMapUrl;
  final String? street;
  final String? ward;
  final String? district;
  final String? province;
  final String? country;
  final bool verified;
  final bool myFavourite;

  Locations({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.ratingCount,
    required this.viewCount,
    required this.username,
    required this.openingHoursDay,
    this.imageUrl,
    required this.locationMapUrl,
    required this.street,
    this.ward,
    this.district,
    required this.province,
    required this.country,
    required this.verified,
    required this.myFavourite,
  });

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rating: json['rating'],
      ratingCount: json['ratingCount'],
      viewCount: json['viewCount'],
      username: json['username'],
      openingHoursDay: json['openingHoursDay'],
      imageUrl: json['imageUrl'],
      locationMapUrl: json['locationMapUrl'],
      street: json['street'],
      ward: json['ward'],
      district: json['district'],
      province: json['province'],
      country: json['country'],
      verified: json['verified'],
      myFavourite: json['myFavourite'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['ratingCount'] = this.ratingCount;
    data['viewCount'] = this.viewCount;
    data['username'] = this.username;
    data['openingHoursDay'] = this.openingHoursDay;
    data['imageUrl'] = this.imageUrl;
    data['locationMapUrl'] = this.locationMapUrl;
    data['street'] = this.street;
    data['ward'] = this.ward;
    data['district'] = this.district;
    data['province'] = this.province;
    data['country'] = this.country;
    data['verified'] = this.verified;
    data['myFavourite'] = this.myFavourite;
    return data;
  }
}
