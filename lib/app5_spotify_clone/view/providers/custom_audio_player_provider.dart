import 'package:audioplayers/audioplayers.dart';
import 'package:comparison/app5_spotify_clone/view_model/custom_audio_player.dart';
import 'package:comparison/app5_spotify_clone/model/entities/music_data.dart';
import 'package:flutter/material.dart';

class CustomAudioPlayerProvider extends CustomAudioPlayer with ChangeNotifier {
  @override
  set playerState(PlayerState playerState) {
    super.playerState = playerState;
    notifyListeners();
  }

  @override
  set isShuffled(bool isShuffled) {
    super.isShuffled = isShuffled;
    notifyListeners();
  }

  @override
  set isLooped(bool isLooped) {
    super.isLooped = isLooped;
    notifyListeners();
  }

  @override
  set pageIndex(int pageIndex) {
    super.pageIndex = pageIndex;
    notifyListeners();
  }

  @override
  set position(Duration position) {
    super.position = position;
    notifyListeners();
  }

  @override
  set duration(Duration duration) {
    super.duration = duration;
    notifyListeners();
  }

  @override
  Future<String?> setAudio(String musicUrl) async {
    super.setAudio(musicUrl);
    notifyListeners();
  }

  @override
  Future<void> resume() async {
    super.resume();
    notifyListeners();
  }

  @override
  Future<void> pause() async {
    super.pause();
    notifyListeners();
  }

  @override
  Future<void> stop() async {
    super.stop();
    notifyListeners();
  }

  @override
  Future<void> start(List<MusicData> musicList, int index) async {
    super.start(musicList, index);
    notifyListeners();
  }

  @override
  Future<void> next() async {
    super.next();
    notifyListeners();
  }

  @override
  Future<void> previous() async {
    super.previous();
    notifyListeners();
  }

  @override
  void addToQueue() {
    super.addToQueue();
    notifyListeners();
  }

  @override
  void removeFromQueue() {
    super.removeFromQueue();
    notifyListeners();
  }

  @override
  Future<void> organizeQueue() async {
    super.organizeQueue();
    notifyListeners();
  }

  @override
  Future<void> createPlaylist() async {
    super.createPlaylist();
    notifyListeners();
  }
}
