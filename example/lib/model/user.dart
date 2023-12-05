enum Gender { male, female }

class User {
  final String id;
  final String name;
  final DateTime birthDate;
  final Gender gender;

  User({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.gender,
  });
}
