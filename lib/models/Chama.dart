
class Chama {
  final int id;
  final String identifier;
  final String name;
  final int userId;
  final int maxNo;
  final int contribution;
  final String chair;
  final String treasurer;
  final String rep;
  final DateTime dateCreated;

  const Chama({
    required this.id,
    required this.identifier,
    required this.name,
    required this.userId,
    required this.maxNo,
    required this.contribution,
    required this.chair,
    required this.treasurer,
    required this.rep,
    required this.dateCreated,
  });

  factory Chama.fromJson(Map<String, dynamic> json) {
    return Chama(
      id: int.parse(json['id']),
      identifier: json['identifier'],
      name: json['name'],
      userId: int.parse(json['userid']),
      maxNo: int.parse(json['max_no']),
      contribution: int.parse(json['contribution']),
      chair: json['chair'],
      treasurer: json['treasurer'],
      rep: json['rep'],
      dateCreated: DateTime.parse(json['date_created']),
    );
  }
}
