import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class YTSearchClient {
  static const String _baseUrl = 'https://yt-app-api.vercel.app/api';

  /// Search for videos, playlists, channels, and live streams.
  /// [query] - The search query.
  /// [page] - Optional page number for pagination.
  /// [type] - Optional type filter (video, playlist, channel, live, all).
  /// [ip] - Optional IP address for localized results.
  Future<SearchResult> search(
    String query, {
    int? page,
    String? type,
    String? ip,
  }) async {
    final params = {
      'q': query,
      if (page != null) 'page': page.toString(),
      if (type != null) 'type': type,
      if (ip != null) 'ip': ip,
    };
    final uri = Uri.parse('$_baseUrl/search').replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return SearchResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search: ${response.statusCode}');
    }
  }

  /// Fetch trending videos from YouTube by category.
  /// [category] - Optional category (e.g., Music, Gaming).
  /// [page] - Optional page number for pagination.
  /// [country] - Optional country code (e.g., IN, US).
  /// [ip] - Optional IP address for localized results.
  Future<TrendingResponse> getTrending({
    String? category,
    int? page,
    String? country,
    String? ip,
  }) async {
    final params = {
      if (category != null) 'category': category,
      if (page != null) 'page': page.toString(),
      if (country != null) 'country': country,
      if (ip != null) 'ip': ip,
    };
    final uri = Uri.parse(
      '$_baseUrl/trending',
    ).replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return TrendingResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch trending: ${response.statusCode}');
    }
  }

  /// Get video recommendations based on a specific video ID.
  /// [videoId] - The ID of the video to get recommendations for.
  /// [page] - Optional page number for pagination.
  /// [ip] - Optional IP address for localized results.
  Future<RelatedResponse> getRelated({
    String? videoId,
    String? url,
    int? page,
    String? ip,
  }) async {
    final params = {
      if (videoId != null) 'id': videoId,
      if (url != null) 'url': url,
      if (page != null) 'page': page.toString(),
      if (ip != null) 'ip': ip,
    };
    final uri = Uri.parse('$_baseUrl/related').replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return RelatedResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch related: ${response.statusCode}');
    }
  }

  /// Get full metadata for a specific video.
  /// [videoId] - Optional video ID.
  /// [url] - Optional full YouTube URL.
  Future<VideoDetail> getVideoDetail({String? videoId, String? url}) async {
    final params = {
      if (videoId != null) 'id': videoId,
      if (url != null) 'url': url,
    };
    final uri = Uri.parse('$_baseUrl/video').replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return VideoDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch video detail: ${response.statusCode}');
    }
  }

  /// Fetch all videos and metadata for a playlist.
  /// [playlistId] - Optional playlist ID.
  /// [url] - Optional full YouTube URL.
  /// [page] - Optional page number for pagination.
  Future<PlaylistDetail> getPlaylistDetail({
    String? playlistId,
    String? url,
    int? page,
  }) async {
    final params = {
      if (playlistId != null) 'id': playlistId,
      if (url != null) 'url': url,
      if (page != null) 'page': page.toString(),
    };
    final uri = Uri.parse('$_baseUrl/playlist').replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return PlaylistDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to fetch playlist detail: ${response.statusCode}',
      );
    }
  }

  /// Fetch channel metadata using a query, ID, or full handle URL.
  /// [queryOrId] - Optional query or channel ID.
  /// [url] - Optional full channel URL.
  Future<ChannelDetail> getChannelDetail({String? queryOrId, String? url}) async {
    final params = {
      if (queryOrId != null) 'query': queryOrId,
      if (url != null) 'url': url,
    };
    final uri = Uri.parse('$_baseUrl/channel').replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return ChannelDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch channel detail: ${response.statusCode}');
    }
  }
}
