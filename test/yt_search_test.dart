import 'package:flutter_test/flutter_test.dart';

import 'package:yt_search/yt_search.dart';

void main() {
  test('YTSearchClient can be initialized', () {
    final client = YTSearchClient();
    expect(client, isNotNull);
  });
}
