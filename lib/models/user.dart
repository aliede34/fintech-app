class User {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final double balance;
  final String accountNumber;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.balance,
    required this.accountNumber,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    double? balance,
    String? accountNumber,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      balance: balance ?? this.balance,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'balance': balance,
      'accountNumber': accountNumber,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      balance: (json['balance'] ?? 0.0).toDouble(),
      accountNumber: json['accountNumber'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, phoneNumber: $phoneNumber, balance: $balance, accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.balance == balance &&
        other.accountNumber == accountNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        balance.hashCode ^
        accountNumber.hashCode;
  }
}
