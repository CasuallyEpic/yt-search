# YT Search API Wrapper

A powerful, high-performance Dart and Flutter package for fetching YouTube metadata, trending videos, related recommendations, and searching for videos, playlists, and channels using the [YT App API](https://yt-app-api.vercel.app/docs.html).

## ✨ Features

- 🔍 **Powerful Search**: Search videos, playlists, channels, and live streams with filters and pagination.
- 🔥 **Trending**: Fetch trending videos by category (Music, Gaming, etc.) and region.
- 🔗 **Related Recommendations**: Get high-quality video recommendations for any YouTube video.
- 📦 **Full Metadata**: Comprehensive information for videos, playlists, and channels.
- ⚡ **Performance**: Optimized for speed with pagination support and localized IP options.
- 🛠️ **Polymorphic Parsing**: Uses Dart Sealed Classes for effortless and type-safe results.

---

## 🚀 Installation

Add the following to your `pubspec.yaml` to use it via GitHub:

```yaml
dependencies:
  yt_search:
    git:
      url: https://github.com/CasuallyEpic/yt-search.git
      ref: main
```

Run `flutter pub get` to fetch the package.

---

## 🏗️ Getting Started

Import the package and initialize the `YTSearchClient`:

```dart
import 'package:yt_search/yt_search.dart';

void main() async {
  final client = YTSearchClient();
  // Ready to use!
}
```

---

## 📖 API Reference

### 1. `search`
Search for videos, playlists, channels, and more.

```dart
SearchResult result = await client.search(
  'flutter',
  page: 1,           // Optional page number
  type: 'video',     // Optional (video, playlist, channel, live, all)
  ip: '1.1.1.1',     // Optional for localized results
);

// Accessing results
print(result.query);
print(result.resultsCount);
print(result.videos.first.title);
```

### 2. `getTrending`
Fetch current trending videos on YouTube.

```dart
TrendingResponse trending = await client.getTrending(
  category: 'music', // Optional (music, gaming, etc.)
  country: 'IN',     // Optional ISO country code
  page: 1,           // Optional page number
);

print(trending.category);
print(trending.videos.first.title);
```

### 3. `getRelated`
Get video recommendations (More like this).

```dart
RelatedResponse related = await client.getRelated(
  'videoIdhere',
  page: 1,           // Optional page number
  ip: '1.1.1.1',     // Optional for localization
);

print(related.originalVideo['title']);
print(related.recommendations.first.title);
```

### 4. `getVideoDetail`
Fetch all metadata for a specific YouTube video.

```dart
VideoDetail video = await client.getVideoDetail('videoIdhere');

print(video.title);
print(video.description);
print(video.author.name);
print(video.views);
```

### 5. `getPlaylistDetail`
Fetch metadata and all videos from a playlist.

```dart
PlaylistDetail playlist = await client.getPlaylistDetail(
  'playlistIdhere',
  page: 1,           // Optional page number
);

print(playlist.title);
print(playlist.totalVideoCount);
print(playlist.videos.first.title);
```

### 6. `getChannelDetail`
Fetch high-quality channel metadata.

```dart
ChannelDetail channel = await client.getChannelDetail('channelIdOrQuery');

print(channel.name);
print(channel.thumbnail);
print(channel.url);
```

---

## 📂 Models

This package uses **Polymorphic Sealed Classes** for type safety. The search results and common items are structured as following:

- **MediaItem**: Base class for all items.
  - **VideoItem**: A standard YouTube video.
  - **PlaylistItem**: A YouTube playlist.
  - **ChannelItem**: A YouTube channel.
  - **LiveItem**: A live stream result.

You can use `switch` with these types easily:

```dart
for (var item in searchResult.all) {
  switch (item) {
    case VideoItem v: print("Video: ${v.title}");
    case PlaylistItem p: print("Playlist: ${p.title}");
    case ChannelItem c: print("Channel: ${c.name}");
    case LiveItem l: print("Live: ${l.status}");
  }
}
```

---

## 🏗️ Workflows

To ensure the library remains stable and clean, follow these common maintenance workflows:

### 1. Verification (Local Testing)
Before pushing any changes to the library, use the built-in scratchpad scripts to verify API responses:
```bash
# Test all major endpoints
flutter pub run scratch/test_api.dart

# Inspect raw JSON for specific endpoints
flutter pub run scratch/inspect_search.dart
flutter pub run scratch/inspect_trending.dart
```

### 2. Formatting & Linting
Always format your code and check for issues before committing:
```bash
# Format the entire codebase
dart format .

# Check for static analysis issues
flutter analyze

# Automatically fix common issues/lints
dart fix --apply
```

### 3. CI/CD (GitHub Actions)
This repository is configured with a GitHub Action that automatically triggers on every push to `main`. It performs the following:
- 🛠️ **Setup Flutter SDK**
- 📦 **Fetch Dependencies** (`flutter pub get`)
- 🔍 **Static Analysis** (`flutter analyze`)
- 🧪 **Unit Tests** (`flutter test`)

---

## 📄 License

This package is licensed under the MIT License.
