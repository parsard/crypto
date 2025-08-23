import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String nationalCode;
  final List<BankCard> bankCards;

  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.nationalCode,
    required this.bankCards,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      nationalCode: json['nationalCode'] ?? '',
      bankCards: (json['bankCards'] as List<dynamic>? ?? []).map((cardJson) => BankCard.fromJson(cardJson)).toList(),
    );
  }

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [firstName, lastName, email, mobile, nationalCode, bankCards];
}

class BankCard extends Equatable {
  final String number;
  final String bank;
  final String owner;
  final bool confirmed;

  const BankCard({
    required this.number,
    required this.bank,
    required this.owner,
    required this.confirmed,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) {
    return BankCard(
      number: json['number'] ?? 'N/A',
      bank: json['bank'] ?? 'N/A',
      owner: json['owner'] ?? 'N/A',
      confirmed: json['confirmed'] ?? false,
    );
  }

  @override
  List<Object?> get props => [number, bank, owner, confirmed];
}
