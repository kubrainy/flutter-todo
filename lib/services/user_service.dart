import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users')
    );
    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      return data
      .map((e) => User.fromJson(e as Map<String, dynamic>))
      .toList();
    }
    throw Exception('Kullanıcılar alınamadı : ${response.statusCode}');
  }
}