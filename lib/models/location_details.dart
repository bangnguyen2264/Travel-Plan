class LocationDetails {
  final String id;
  final String? name;
  final String? description;
  final String? content;
  final double rating;
  final int ratingCount;
  final int viewCount;
  final String? username;
  final int maxCost;
  final int minCost;
  final String? locationMapUrl;
  final List<String> imageUrls;
  final String? openingHoursDay;
  final Address? address;
  final Contact? contact;
  final List<String> categories;
  final String createdAt;
  final String updatedAt;
  final bool verified;
  final bool myFavourite;

  LocationDetails({
    required this.id,
    this.name,
    this.description,
    this.content,
    required this.rating,
    required this.ratingCount,
    required this.viewCount,
    this.username,
    required this.maxCost,
    required this.minCost,
    this.locationMapUrl,
    required this.imageUrls,
    this.openingHoursDay,
    this.address,
    this.contact,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
    required this.verified,
    required this.myFavourite,
  });

  factory LocationDetails.fromJson(Map<String, dynamic> json) {
    return LocationDetails(
      id: json['id'] ?? '',
      name: json['name'],
      description: json['description'],
      content: json['content'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      ratingCount: json['ratingCount'] ?? 0,
      viewCount: json['viewCount'] ?? 0,
      username: json['username'],
      maxCost: json['maxCost'] ?? 0,
      minCost: json['minCost'] ?? 0,
      locationMapUrl: json['locationMapUrl'],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      openingHoursDay: json['openingHoursDay'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      contact:
          json['contact'] != null ? Contact.fromJson(json['contact']) : null,
      categories: List<String>.from(json['categories'] ?? []),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      verified: json['verified'] ?? false,
      myFavourite: json['myFavourite'] ?? false,
    );
  }
}

class Address {
  final String id;
  final double latitude;
  final double longitude;
  final String? street;
  final String? ward;
  final String district;
  final String province;
  final String country;

  Address({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.street,
    this.ward,
    required this.district,
    required this.province,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      street: json['street'],
      ward: json['ward'],
      district: json['district'] ?? '',
      province: json['province'] ?? '',
      country: json['country'] ?? '',
    );
  }
}

class Contact {
  final String id;
  final String? email;
  final String? phoneNumber;
  final String? website;
  final String? facebook;
  final String? nameContact;

  Contact({
    required this.id,
    this.email,
    this.phoneNumber,
    this.website,
    this.facebook,
    this.nameContact,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      website: json['website'],
      facebook: json['facebook'],
      nameContact: json['nameContact'],
    );
  }
}
