
class Kin {
  final int id;
  final String name;
  final String address;
  final String contact;
  final String email;
  final String relationship;
  final int userId;
  final DateTime createdAt;

  const Kin({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
    required this.relationship,
    required this.userId,
    required this.createdAt,
  });

  factory Kin.fromJson(Map<String, dynamic> json) {
    return Kin(
      id: int.parse(json['id']),
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
      relationship: json['relationship'] ?? '',
      userId: int.parse(json['user_id']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
