import "dart:convert";
import "package:http/http.dart" as http;

import "../models/Users.dart";

class UserService {
  static String ROOT2 = "http:/192.168.1.2/projects/fintech/api/users.php";
  static String ROOT = "https://introtech.co.ke/projects/fintech/api/users.php";
  
  static const _CREATE_TABLE_ACTION = "CREATE_TABLE";
  static const _GET_ALL_ACTION = "GET_ALL";
  static const _ADD_User_ACTION = "ADD_User";
  static const _UPDATE_User_ACTION = "UPDATE_User";
  static const _DELETE_User_ACTION = "DELETE_User";
  static const _LOGIN_User_ACTION = "LOGIN_MOBILE_USER";

  static Future<String> createTable() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("Create Table Response: ${response.body}");
      print("Create Table Status: ${response.statusCode}");
      print("Create Table String: ${response.toString()}");
      if(200 == response.statusCode){      
        return "success";      
      } else {
        return "error";      
      }
    } catch (e) {
      print("Error occurred: $e");
      return "error $e";      
    }
  }

  static Future<List<User>> getUser() async {
    List<User> list = [];
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("Get All Users Response: ${response.body}");

      if(200 == response.statusCode){
        // list = parseResponse(response.body);
        return list;
      }
    } catch (e) {
      print("Error occurred: $e");
      return list;      
    }
    return list;    
  }

  static List<User> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['last_name'] as String,
      idnum: json['idnum'] as String,
      loanlimit: json['loanlimit'] as String,
      pwd: json['pwd'] as String),
    ).toList();
  }

  static Future<String> addUser(String firstName, String lastName, String email, String pswd, String created_at) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_User_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['email'] = email;
      map['pswd'] = pswd;
      map['created_at'] = created_at;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print("Add User Response: ${response.body}");

      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    } catch (e) {   
        print("Adding Driver Error Caught::: $e");
        return "error $e";
    }
  }
// add User
  static Future<String> loginUser(String idnum, String pswd) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _LOGIN_User_ACTION;
      map['idnum'] = idnum;
      map['pswd'] = pswd;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print(idnum);
      print(pswd);
      print("Login User Response: ${response.statusCode}");

      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    } catch (e) {   
        print("Login User Error Caught::: $e");
        return "error $e";
    }
  }

  static Future<String> updateUser(String driverId, String firstName, String lastName, String email, String pswd, String created_at) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_User_ACTION;
      map['driver_id'] = driverId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['email'] = email;
      map['pswd'] = pswd;
      map['created_at'] = created_at;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print("Update User Response: ${response.body}");

      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    } catch (e) {   
        return "error $e";
    }
  }
  
  static Future<String> deleteUser(String driverId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_User_ACTION;
      map['driver_id'] = driverId;

      final response = await http.post(Uri.parse(ROOT), body: map);
      print("Delete User Response: ${response.body}");

      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    } catch (e) {   
        return "error $e";
    }
  }
}
