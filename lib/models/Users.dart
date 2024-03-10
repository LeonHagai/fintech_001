// A simple User class to represent user data
class User {
  final String id;
  final String name;
  final String idnum;
  final String phone;
  final String loanlimit;
  final String pwd;

  User({required this.id, required this.name,  required this.idnum,  required this.phone,  required this.loanlimit,  required this.pwd});

    factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'] as String, 
      name: json['name'] as String, 
      idnum: json['idnum'] as String, 
      phone: json['phone'] as String, 
      loanlimit: json['loanlimit'] as String, 
      pwd: json['pwd'] as String,       
    );
  }
}