import 'package:yt_search/yt_search.dart';

void main() async {
  final client = YTSearchClient();

  print('--- Testing Search ---');
  try {
    final searchResult = await client.search('flutter', page: 1);
    print('Search Query: ${searchResult.query}');
    print('Results Count: ${searchResult.resultsCount}');
    if (searchResult.videos.isNotEmpty) {
      print('First Video: ${searchResult.videos.first.title}');
    }
    if (searchResult.playlists.isNotEmpty) {
      print('First Playlist: ${searchResult.playlists.first.title}');
    }
    if (searchResult.channels.isNotEmpty) {
      print('First Channel: ${searchResult.channels.first.name}');
    }
  } catch (e) {
    print('Search error: $e');
  }

  print('\n--- Testing Trending ---');
  try {
    final trending =
        await client.getTrending(category: 'music', country: 'IN', page: 1);
    print('Category: ${trending.category}');
    if (trending.videos.isNotEmpty) {
      print('First Trending Video: ${trending.videos.first.title}');
    }
  } catch (e) {
    print('Trending error: $e');
  }

  print('\n--- Testing Related ---');
  try {
    final related = await client.getRelated('lHhRhPV--G0');
    print('Original Video: ${related.originalVideo['title']}');
    print('First Recommendation: ${related.recommendations.first.title}');
  } catch (e) {
    print('Related error: $e');
  }

  print('\n--- Testing Video Detail ---');
  try {
    final video = await client.getVideoDetail('lHhRhPV--G0');
    print('Video Title: ${video.title}');
    print('Author: ${video.author.name}');
    print('Views: ${video.views}');
  } catch (e) {
    print('Video Detail error: $e');
  }

  print('\n--- Testing Playlist Detail ---');
  try {
    final playlist = await client.getPlaylistDetail('PLjVLYmrlmjGfGLShoW0vVX_tcyT8u1Y3E');
    print('Playlist Title: ${playlist.title}');
    print('Total Video Count: ${playlist.totalVideoCount}');
    print('Results Count on this page: ${playlist.resultsCount}');
    print('First Video in Playlist: ${playlist.videos.first.title}');
  } catch (e) {
    print('Playlist Detail error: $e');
  }

  print('\n--- Testing Channel Detail ---');
  try {
    final channel = await client.getChannelDetail('flutter');
    print('Channel Name: ${channel.name}');
    print('Channel URL: ${channel.url}');
  } catch (e) {
    print('Channel Detail error: $e');
  }
}
