import 'package:http/http.dart' as http;

void main() async {
  final uri = Uri.parse(
    'https://yt-app-api.vercel.app/api/search?q=flutter&page=1',
  );
  final response = await http.get(uri);
  print('Status: ${response.statusCode}');
  if (response.body.length > 500) {
    print(response.body.substring(0, 500));
  } else {
    print(response.body);
  }
}
