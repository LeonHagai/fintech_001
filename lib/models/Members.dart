
class Members {
  final String id;
  final String name;
  final String address;
  final String contact;
  final String email;
  final String relationship;
  final String userId;
  final String createdAt;

  const Members({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
    required this.relationship,
    required this.userId,
    required this.createdAt,
  });

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      id: json['id']  ?? '',
      name: json['name'] ?? '',
      address: json['phone'] ?? '',
      contact: json['phone'] ?? '',
      email: json['email'] ?? '',
      relationship: json['relationship'] ?? '',
      userId: json['idnum'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
