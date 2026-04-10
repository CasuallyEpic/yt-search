import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final uri = Uri.parse('https://yt-app-api.vercel.app/api/search?q=flutter&page=1');
  final response = await http.get(uri);
  final map = jsonDecode(response.body) as Map<String, dynamic>;
  print('Keys at top level: ${map.keys.toList()}');
  if (map.containsKey('results')) {
    final results = map['results'] as Map<String, dynamic>;
    print('Keys in results: ${results.keys.toList()}');
  }
}
