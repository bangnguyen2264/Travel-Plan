class User {
  final String id;
  final String username;
  final String email;
  final String role;
  final String firstName;
  final String lastName;
  final String avatar;
  final String? dataOfBirth;
  final bool enabled;
  final String? authorizedClientRegistration;
  final String? locale;
  final String? phone;
  final String? dob;
  final String? gender;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    this.dataOfBirth,
    required this.enabled,
    this.authorizedClientRegistration,
    this.locale,
    this.phone,
    this.dob,
    this.gender,
  });
  User.fromJson(Map<String, dynamic> json)
      :   id = json['id'],
          username = json['username'],
          email = json['email'],
          role = json['role'],
          firstName = json['firstName'],
          lastName = json['lastName'],
          avatar = json['avatar'],
          dataOfBirth = json['dataOfBirth'],
          enabled = json['enabled'],
          authorizedClientRegistration = json['authorizedClientRegistration'],
          locale = json['locale'],
          phone = json['phone'],
          dob = json['dob'],
          gender = json['gender'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'dataOfBirth': dataOfBirth,
      'enabled': enabled,
      'authorizedClientRegistration': authorizedClientRegistration,
      'locale': locale,
      'phone': phone,
      'dob': dob,
      'gender':gender,
    };
  }
}
