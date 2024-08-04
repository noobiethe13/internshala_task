import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/internship_model.dart';

class InternshipService {
  static const String _baseUrl = 'https://internshala.com/flutter_hiring/search';

  Future<List<Internship>> fetchInternships() async {
    final uri = Uri.parse(_baseUrl);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<Internship> internships = [];

      if (jsonMap.containsKey('internships_meta')) {
        final internshipsMeta = jsonMap['internships_meta'] as Map<String, dynamic>;
        internshipsMeta.forEach((key, value) {
          if (value is Map<String, dynamic>) {
            internships.add(Internship.fromJson(value));
          }
        });
      }

      return internships;
    } else {
      throw Exception('Failed to load internships');
    }
  }
}
