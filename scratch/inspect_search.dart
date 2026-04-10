import 'package:http/http.dart' as http;

void main() async {
  final uri = Uri.parse(
    'https://yt-app-api.vercel.app/api/search?q=flutter&page=1',
  );
  final response = await http.get(uri);
  print(response.body);
}
