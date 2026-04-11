sealed class MediaItem {
  final String type;
  final String id;
  final String title;
  final String thumbnail;
  final String url;
  final String author;

  MediaItem({
    required this.type,
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.url,
    required this.author,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'video':
        return VideoItem.fromJson(json);
      case 'playlist':
        return PlaylistItem.fromJson(json);
      case 'channel':
        return ChannelItem.fromJson(json);
      case 'live':
        return LiveItem.fromJson(json);
      default:
        throw Exception('Unknown type: $type');
    }
  }
}

class VideoItem extends MediaItem {
  final String duration;
  final int views;
  final String? ago;
  final String? description;
  final String? authorUrl;

  VideoItem({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.url,
    required super.author,
    required this.duration,
    required this.views,
    this.ago,
    this.description,
    this.authorUrl,
  }) : super(type: 'video');

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      url: json['url'] as String,
      author: json['author'] as String,
      duration: json['duration'] as String,
      views: json['views'] as int,
      ago: json['ago'] as String?,
      description: json['description'] as String?,
      authorUrl: json['authorUrl'] as String?,
    );
  }
}

class PlaylistItem extends MediaItem {
  final int videoCount;

  PlaylistItem({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.url,
    required super.author,
    required this.videoCount,
  }) : super(type: 'playlist');

  factory PlaylistItem.fromJson(Map<String, dynamic> json) {
    return PlaylistItem(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      url: json['url'] as String,
      author: json['author'] as String,
      videoCount: json['videoCount'] as int,
    );
  }
}

class ChannelItem extends MediaItem {
  final String name;

  ChannelItem({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.url,
    required this.name,
  }) : super(type: 'channel', author: name);

  factory ChannelItem.fromJson(Map<String, dynamic> json) {
    return ChannelItem(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      url: json['url'] as String,
      name: json['name'] as String,
    );
  }
}

class LiveItem extends MediaItem {
  final String status;

  LiveItem({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.url,
    required super.author,
    required this.status,
  }) : super(type: 'live');

  factory LiveItem.fromJson(Map<String, dynamic> json) {
    return LiveItem(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      url: json['url'] as String,
      author: json['author'] as String,
      status: json['status'] as String? ?? 'live',
    );
  }
}

class SearchResult {
  final String query;
  final int page;
  final String typeRequested;
  final int resultsCount;
  final List<VideoItem> videos;
  final List<PlaylistItem> playlists;
  final List<ChannelItem> channels;
  final List<LiveItem> live;
  final List<MediaItem> all;
  final String? ip;

  SearchResult({
    required this.query,
    required this.page,
    required this.typeRequested,
    required this.resultsCount,
    required this.videos,
    required this.playlists,
    required this.channels,
    required this.live,
    required this.all,
    this.ip,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as Map<String, dynamic>? ?? {};
    return SearchResult(
      query: json['query'] as String? ?? '',
      page: json['page'] as int? ?? 1,
      typeRequested: json['typeRequested'] as String? ?? 'all',
      resultsCount: json['resultsCount'] as int? ?? 0,
      videos: (results['videos'] as List?)
              ?.map((v) => VideoItem.fromJson(v))
              .toList() ??
          [],
      playlists: (results['playlists'] as List?)
              ?.map((p) => PlaylistItem.fromJson(p))
              .toList() ??
          [],
      channels: (results['channels'] as List?)
              ?.map((c) => ChannelItem.fromJson(c))
              .toList() ??
          [],
      live: (results['live'] as List?)
              ?.map((l) => LiveItem.fromJson(l))
              .toList() ??
          [],
      all: (json['all'] as List?)?.map((i) => MediaItem.fromJson(i)).toList() ??
          [],
      ip: json['ip'] as String?,
    );
  }
}

class AuthorModel {
  final String name;
  final String url;

  AuthorModel({required this.name, required this.url});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}

class VideoDetail {
  final String type;
  final String id;
  final String title;
  final String description;
  final String url;
  final String thumbnail;
  final int seconds;
  final String duration;
  final int views;
  final String genre;
  final String uploadDate;
  final String ago;
  final AuthorModel author;

  VideoDetail({
    required this.type,
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.thumbnail,
    required this.seconds,
    required this.duration,
    required this.views,
    required this.genre,
    required this.uploadDate,
    required this.ago,
    required this.author,
  });

  factory VideoDetail.fromJson(Map<String, dynamic> json) {
    return VideoDetail(
      type: json['type'] as String? ?? 'video',
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      seconds: json['seconds'] as int? ?? 0,
      duration: json['duration'] as String? ?? '',
      views: json['views'] as int? ?? 0,
      genre: json['genre'] as String? ?? '',
      uploadDate: json['uploadDate'] as String? ?? '',
      ago: json['ago'] as String? ?? '',
      author: json['author'] != null
          ? AuthorModel.fromJson(json['author'])
          : AuthorModel(name: 'Unknown', url: ''),
    );
  }
}

class PlaylistVideo {
  final String id;
  final String title;
  final String thumbnail;
  final String duration;
  final String author;

  PlaylistVideo({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.duration,
    required this.author,
  });

  factory PlaylistVideo.fromJson(Map<String, dynamic> json) {
    return PlaylistVideo(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      duration: json['duration'] as String,
      author: json['author'] as String,
    );
  }
}

class PlaylistDetail {
  final String type;
  final String id;
  final String title;
  final String url;
  final String thumbnail;
  final int totalVideoCount;
  final int resultsCount;
  final int page;
  final AuthorModel author;
  final List<PlaylistVideo> videos;

  PlaylistDetail({
    required this.type,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.totalVideoCount,
    required this.resultsCount,
    required this.page,
    required this.author,
    required this.videos,
  });

  factory PlaylistDetail.fromJson(Map<String, dynamic> json) {
    return PlaylistDetail(
      type: json['type'] as String? ?? 'playlist',
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      totalVideoCount: json['totalVideoCount'] as int? ?? 0,
      resultsCount: json['resultsCount'] as int? ?? 0,
      page: json['page'] as int? ?? 1,
      author: json['author'] != null
          ? AuthorModel.fromJson(json['author'])
          : AuthorModel(name: 'Unknown', url: ''),
      videos: (json['videos'] as List?)
              ?.map((v) => PlaylistVideo.fromJson(v))
              .toList() ??
          [],
    );
  }
}

class ChannelDetail {
  final String type;
  final String id;
  final String name;
  final String url;
  final String thumbnail;

  ChannelDetail({
    required this.type,
    required this.id,
    required this.name,
    required this.url,
    required this.thumbnail,
  });

  factory ChannelDetail.fromJson(Map<String, dynamic> json) {
    return ChannelDetail(
      type: json['type'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }
}

class TrendingResponse {
  final String category;
  final String country;
  final int page;
  final int resultsCount;
  final List<VideoItem> videos;
  final String? ip;

  TrendingResponse({
    required this.category,
    required this.country,
    required this.page,
    required this.resultsCount,
    required this.videos,
    this.ip,
  });

  factory TrendingResponse.fromJson(Map<String, dynamic> json) {
    return TrendingResponse(
      category: json['category'] as String? ?? 'general',
      country: json['country'] as String? ?? '',
      page: json['page'] as int? ?? 1,
      resultsCount: json['resultsCount'] as int? ?? 0,
      videos: (json['videos'] as List?)
              ?.map((v) => VideoItem.fromJson(v))
              .toList() ??
          [],
      ip: json['ip'] as String?,
    );
  }
}

class RelatedResponse {
  final Map<String, dynamic> originalVideo;
  final List<VideoItem> recommendations;
  final int page;
  final String? ip;

  RelatedResponse({
    required this.originalVideo,
    required this.recommendations,
    required this.page,
    this.ip,
  });

  factory RelatedResponse.fromJson(Map<String, dynamic> json) {
    return RelatedResponse(
      originalVideo: json['originalVideo'] as Map<String, dynamic>? ?? {},
      recommendations: (json['recommendations'] as List?)
              ?.map((v) => VideoItem.fromJson(v))
              .toList() ??
          [],
      page: json['page'] as int? ?? 1,
      ip: json['ip'] as String?,
    );
  }
}
