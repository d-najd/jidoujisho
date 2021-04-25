import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path/path.dart' as path;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:jidoujisho/dictionary.dart';
import 'package:jidoujisho/globals.dart';
import 'package:jidoujisho/util.dart';
import 'package:jidoujisho/youtube.dart';

List<String> getChannelList() {
  String prefsChannels = gSharedPrefs.getString('subscribedChannels') ?? '[]';
  List<String> channelIDs =
      (jsonDecode(prefsChannels) as List<dynamic>).cast<String>();

  return channelIDs;
}

Future<void> addNewChannel(String videoURL) async {
  YoutubeExplode yt = YoutubeExplode();

  String channelID = (await yt.channels.getByVideo(videoURL)).id.value;
  String prefsChannels = gSharedPrefs.getString('subscribedChannels') ?? '[]';
  List<String> channelIDs =
      (jsonDecode(prefsChannels) as List<dynamic>).cast<String>();

  gChannelCache = AsyncMemoizer();
  setChannelCache([]);
  if (!channelIDs.contains(channelID)) {
    channelIDs.add(channelID);
  }

  await gSharedPrefs.setString('subscribedChannels', jsonEncode(channelIDs));
}

Future<void> removeChannel(Channel channel) async {
  String channelID = channel.id.value;
  String prefsChannels = gSharedPrefs.getString('subscribedChannels') ?? '[]';
  List<String> channelIDs =
      (jsonDecode(prefsChannels) as List<dynamic>).cast<String>();

  gChannelCache = AsyncMemoizer();
  setChannelCache([]);
  channelIDs.remove(channelID);
  await gSharedPrefs.setString('subscribedChannels', jsonEncode(channelIDs));
}

Future<void> setChannelList(List<String> channelIDs) async {
  await gSharedPrefs.setString('subscribedChannels', jsonEncode(channelIDs));
}

Map<String, dynamic> channelToMap(Channel channel) {
  return {
    "id": channel.id.value,
    "title": channel.title,
    "logoUrl": channel.logoUrl,
  };
}

Channel mapToChannel(Map<String, dynamic> map) {
  ChannelId id = ChannelId.fromString(map['id']);
  String title = map['title'];
  String logoUrl = map['logoUrl'];

  return Channel(id, title, logoUrl);
}

Future<void> setChannelCache(List<Channel> channels) async {
  List<Map<String, dynamic>> maps = [];
  channels.forEach((channel) {
    maps.add(channelToMap(channel));
  });

  await gSharedPrefs.setString('channelCache', jsonEncode(maps));
}

List<Channel> getChannelCache() {
  String prefsChannelCache = gSharedPrefs.getString('channelCache') ?? '[]';
  List<dynamic> maps = (jsonDecode(prefsChannelCache) as List<dynamic>);

  List<Channel> channels = [];
  maps.forEach((map) {
    Channel channel = mapToChannel(map);
    channels.add(channel);
  });

  return channels;
}

List<String> getSearchHistory() {
  String prefsHistory = gSharedPrefs.getString('searchHistory') ?? '[]';
  List<String> history =
      (jsonDecode(prefsHistory) as List<dynamic>).cast<String>();

  return history;
}

Future<void> addSearchHistory(String term) async {
  List<String> history = getSearchHistory();

  if (history.contains(term.trim())) {
    history.remove(term.trim());
  }
  if (term.trim() != "") {
    history.add(term.trim());
  }

  if (history.length >= 14) {
    history = history.sublist(history.length - 14);
  }

  await gSharedPrefs.setString('searchHistory', jsonEncode(history));
}

Future<void> removeSearchHistory(String term) async {
  List<String> history = getSearchHistory();

  history.remove(term);
  await gSharedPrefs.setString('searchHistory', jsonEncode(history));
}

Future<void> setAnkiDroidDirectory(Directory directory) async {
  await gSharedPrefs.setString('ankiDroidDirectory', directory.path);
}

Directory getAnkiDroidDirectory() {
  String directoryPath = gSharedPrefs.getString('ankiDroidDirectory') ??
      'storage/emulated/0/AnkiDroid';
  Directory directory = Directory(directoryPath);

  return directory;
}

Future<void> toggleSelectMode() async {
  await gSharedPrefs.setBool("selectMode", !getSelectMode());
}

bool getSelectMode() {
  return gSharedPrefs.getBool("selectMode") ?? false;
}

Future<void> toggleFocusMode() async {
  await gSharedPrefs.setBool("focusMode", !getFocusMode());
}

bool getFocusMode() {
  return gSharedPrefs.getBool("focusMode") ?? false;
}

bool getResumeAvailable() {
  String lastPlayedPath = getLastPlayedPath();
  return lastPlayedPath != "-1";
}

Future<void> setLastPlayedPath(String path) async {
  await gSharedPrefs.setString("lastPlayedPath", path);
}

String getLastPlayedPath() {
  return gSharedPrefs.getString("lastPlayedPath") ?? "-1";
}

Future<void> setLastPlayedPosition(int positionInSeconds) async {
  await gSharedPrefs.setInt("lastPlayedPosition", positionInSeconds);
}

int getLastPlayedPosition() {
  return gSharedPrefs.getInt("lastPlayedPosition") ?? -1;
}

Future<void> setAudioAllowance(int ms) async {
  await gSharedPrefs.setInt("audioAllowance", ms);
}

int getAudioAllowance() {
  return gSharedPrefs.getInt("audioAllowance") ?? 0;
}

Future<void> setSubtitleDelay(int ms) async {
  await gSharedPrefs.setInt("subtitleDelay", ms);
}

int getSubtitleDelay() {
  return gSharedPrefs.getInt("subtitleDelay") ?? 0;
}

List<VideoHistory> getVideoHistory() {
  String prefsVideoHistory = gSharedPrefs.getString('videoHistory') ?? '[]';
  List<dynamic> history = (jsonDecode(prefsVideoHistory) as List<dynamic>);

  List<VideoHistory> histories = [];
  history.forEach((entry) {
    VideoHistory videoHistory = VideoHistory.fromMap(entry);
    histories.add(videoHistory);
  });

  return histories;
}

Future<void> setVideoHistory(List<VideoHistory> videoHistories) async {
  List<Map<String, dynamic>> maps = [];
  videoHistories.forEach((entry) {
    maps.add(entry.toMap());
  });

  await gSharedPrefs.setString('videoHistory', jsonEncode(maps));
}

Future<void> addVideoHistory(VideoHistory videoHistory) async {
  List<VideoHistory> videoHistories = getVideoHistory();

  if (videoHistory.thumbnail == null) {
    File videoFile = File(videoHistory.url);
    String photoFileNameDir = "$gAppDirPath/" +
        path.basenameWithoutExtension(videoFile.path) +
        ".jpg";
    File photoFile = File(photoFileNameDir);
    if (photoFile.existsSync()) {
      photoFile.deleteSync();
    }

    String formatted = getTimestampFromDuration(Duration(seconds: 5));

    final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

    String inputPath = videoHistory.url;
    String exportPath = "\"$photoFileNameDir\"";

    String command =
        "-loglevel quiet -ss $formatted -y -i \"$inputPath\" -frames:v 1 -q:v 2 $exportPath";

    await _flutterFFmpeg.execute(command);

    videoHistory.thumbnail = photoFileNameDir;
  }

  videoHistories.removeWhere((entry) => entry.url == videoHistory.url);
  videoHistories.add(videoHistory);

  if (videoHistories.length >= 20) {
    videoHistories.sublist(0, videoHistories.length - 20).forEach((entry) {
      if (!entry.thumbnail.startsWith("http")) {
        File photoFile = File(entry.thumbnail);
        if (photoFile.existsSync()) {
          photoFile.deleteSync();
        }
      }
    });
    videoHistories = videoHistories.sublist(videoHistories.length - 20);
  }

  await setVideoHistory(videoHistories);
}

Future<void> removeVideoHistory(VideoHistory videoHistory) async {
  List<VideoHistory> videoHistories = getVideoHistory();

  videoHistories.removeWhere((entry) => entry.url == videoHistory.url);
  if (!videoHistory.thumbnail.startsWith("http")) {
    File photoFile = File(videoHistory.thumbnail);
    if (photoFile.existsSync()) {
      photoFile.deleteSync();
    }
  }

  await setVideoHistory(videoHistories);
}

List<DictionaryEntry> getDictionaryHistory() {
  String prefsDictionary = gSharedPrefs.getString('dictionaryHistory') ?? '[]';
  List<dynamic> history = (jsonDecode(prefsDictionary) as List<dynamic>);

  List<DictionaryEntry> entries = [];
  history.forEach((map) {
    DictionaryEntry entry = DictionaryEntry.fromMap(map);
    entries.add(entry);
  });

  return entries;
}

Future<void> setDictionaryHistory(
    List<DictionaryEntry> dictionaryEntries) async {
  List<Map<String, dynamic>> maps = [];
  dictionaryEntries.forEach((entry) {
    maps.add(entry.toMap());
  });

  await gSharedPrefs.setString('dictionaryHistory', jsonEncode(maps));
}

Future<void> addDictionaryEntryToHistory(
    DictionaryEntry dictionaryEntry) async {
  List<DictionaryEntry> dictionaryEntries = getDictionaryHistory();

  dictionaryEntries.removeWhere(
    (entry) => entry.word == dictionaryEntry.word,
  );
  dictionaryEntries.add(dictionaryEntry);

  if (dictionaryEntries.length >= 100) {
    dictionaryEntries =
        dictionaryEntries.sublist(dictionaryEntries.length - 100);
  }

  await setDictionaryHistory(dictionaryEntries);
}

Future<void> removeDictionaryEntryFromHistory(
    DictionaryEntry dictionaryEntry) async {
  List<DictionaryEntry> dictionaryEntries = getDictionaryHistory();

  dictionaryEntries.removeWhere(
    (entry) => entry.word == dictionaryEntry.word,
  );

  await setDictionaryHistory(dictionaryEntries);
}

YouTubeQualityOption getLastPlayedQuality(
    List<YouTubeQualityOption> qualities) {
  String lastPlayedQuality = gSharedPrefs.getString("lastPlayedQuality");

  if (lastPlayedQuality != null) {
    for (YouTubeQualityOption quality in qualities) {
      // If we find the quality they last played, we return that.
      if (quality.videoResolution == lastPlayedQuality) {
        return quality;
      }
    }
    // In this case, we know that they have set a quality that doesn't exist,
    // maybe it's a low quality video -- so we take the best quality.
    return qualities.lastWhere((element) => element.muxed) ?? qualities.last;
  } else {
    // We don't know if we could abuse their mobile data,
    // let's try the average.
    return qualities.firstWhere(
            (element) => element.videoResolution == "360p" || element.muxed) ??
        qualities.first;
  }
}