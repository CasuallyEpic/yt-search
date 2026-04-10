import 'package:http/http.dart' as http;

void main() async {
  final uri = Uri.parse('https://yt-app-api.vercel.app/api/trending?category=music');
  final response = await http.get(uri);
  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
}
