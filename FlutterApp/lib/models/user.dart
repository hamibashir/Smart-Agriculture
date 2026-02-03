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
  final bool emailVerified;
  final bool phoneVerified;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final DateTime? updatedAt;

  const User({
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
    required this.emailVerified,
    required this.phoneVerified,
    required this.createdAt,
    this.lastLogin,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['user_id'],
        fullName: json['full_name'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        city: json['city'],
        province: json['province'],
        postalCode: json['postal_code'],
        role: json['role'] ?? 'farmer',
        isActive: _parseBool(json['is_active']),
        emailVerified: _parseBool(json['email_verified']),
        phoneVerified: _parseBool(json['phone_verified']),
        createdAt: DateTime.parse(json['created_at']),
        lastLogin: _parseDateTime(json['last_login']),
        updatedAt: _parseDateTime(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'province': province,
        'postal_code': postalCode,
        'role': role,
        'is_active': isActive,
        'email_verified': emailVerified,
        'phone_verified': phoneVerified,
        'created_at': createdAt.toIso8601String(),
        'last_login': lastLogin?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  static bool _parseBool(dynamic value) => value == 1 || value == true;

  static DateTime? _parseDateTime(dynamic value) => value != null ? DateTime.parse(value) : null;
}