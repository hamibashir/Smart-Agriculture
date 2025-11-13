class User {
  final int userId;
  final String fullName;
  final String email;
  final String phone;
  final String? address;
  final String? city;
  final String? province;
  final String? postalCode;
  final String role;
  final bool isActive;
  final bool? emailVerified;
  final bool? phoneVerified;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final DateTime? updatedAt;

  User({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    this.address,
    this.city,
    this.province,
    this.postalCode,
    required this.role,
    required this.isActive,
    this.emailVerified,
    this.phoneVerified,
    required this.createdAt,
    this.lastLogin,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      province: json['province'],
      postalCode: json['postal_code'],
      role: json['role'] ?? 'farmer',
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      emailVerified: json['email_verified'] == 1 || json['email_verified'] == true,
      phoneVerified: json['phone_verified'] == 1 || json['phone_verified'] == true,
      createdAt: DateTime.parse(json['created_at']),
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'province': province,
      'role': role,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
