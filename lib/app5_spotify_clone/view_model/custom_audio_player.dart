import 'package:audioplayers/audioplayers.dart';
import 'package:comparison/app5_spotify_clone/model/entities/music_data.dart';

class CustomAudioPlayer {
  AudioPlayer player = AudioPlayer();

  PlayerState _playerState = PlayerState.paused;
  bool _isShuffled = false;
  bool _isLooped = false;
  int _queueIndex = 0;
  int _pageIndex = 0;
  Duration _position = Duration.zero;
  Duration _duration = const Duration(milliseconds: 10);
  List<MusicData> _originalQueue = [];
  List<MusicData> _queue = [];
  List<MusicData> _playlist = [];

  PlayerState get playerState => _playerState;

  bool get isShuffled => _isShuffled;

  bool get isLooped => _isLooped;

  int get pageIndex => _pageIndex;

  int get queueIndex => _queueIndex;

  Duration get position => _position;

  Duration get duration => _duration;

  List<MusicData> get queue => _queue;

  List<MusicData> get playlist => _playlist;

  bool get isPlaying => _playerState == PlayerState.playing;

  set playerState(PlayerState playerState) => _playerState = playerState;

  set isShuffled(bool isShuffled) => _isShuffled = isShuffled;

  set isLooped(bool isLooped) => _isLooped = isLooped;

  set pageIndex(int pageIndex) => _pageIndex = pageIndex;

  set position(Duration position) => _position = position;

  set duration(Duration duration) => _duration = duration;
  ///
  ///################################################################################
  ///
  Future<String?> setAudio(String musicUrl) async {
    try {
      await player.setSource(AssetSource(musicUrl));
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<void> resume() async {
    await player.resume();
    _playerState = PlayerState.playing;
  }

  Future<void> pause() async {
    await player.pause();
    _playerState = PlayerState.paused;
  }

  Future<void> stop() async {
    await player.stop();
    _position = Duration.zero;
    _playerState = PlayerState.stopped;
  }

  Future<void> start(List<MusicData> musicList, int index) async {
    _originalQueue = [...musicList];
    _queueIndex = index;
    _queue = [..._originalQueue];
    await createPlaylist();

    await setAudio(_playlist[_pageIndex].musicUrl);

    _position = Duration.zero;
    resume();
  }

  Future<void> next() async {
    if (_queueIndex == _queue.length - 1) {
      _queueIndex = 0;
    } else {
      _queueIndex += 1;
    }
    await createPlaylist();

    await setAudio(_playlist[_pageIndex].musicUrl);

    _position = Duration.zero;
    resume();
  }

  Future<void> previous() async {
    if (_queueIndex == 0) {
      _queueIndex = _queue.length - 1;
    } else {
      _queueIndex -= 1;
    }
    await createPlaylist();

    await setAudio(_playlist[_pageIndex].musicUrl);

    _position = Duration.zero;
    resume();
  }

  void addToQueue() {}

  void removeFromQueue() {}

  Future<void> organizeQueue() async {
    MusicData currentElement = _queue.removeAt(_queueIndex);
    if (_isShuffled) {
      _queue.shuffle();
      _queue.insert(0, currentElement);
      _queueIndex = 0;
    } else {
      _queue = [..._originalQueue];
      _queueIndex = _queue.indexOf(currentElement);
    }
    await createPlaylist();
  }

  Future<void> createPlaylist() async {
    if (_isLooped) {
      if (_queueIndex == 0) {
        _playlist = [_queue.last] + _queue.sublist(0, 2);
      } else if (_queueIndex == _queue.length - 1) {
        _playlist = _queue.sublist(_queueIndex - 1) + [_queue.first];
      } else {
        _playlist = _queue.sublist(_queueIndex - 1, _queueIndex + 2);
      }
    } else {
      if (_queueIndex == 0) {
        _playlist = _queue.sublist(0, 2);
      } else if (_queueIndex == _queue.length - 1) {
        _playlist = _queue.sublist(_queueIndex - 1);
      } else {
        _playlist = _queue.sublist(_queueIndex - 1, _queueIndex + 2);
      }
    }
    if (_playlist.length == 3) {
      _pageIndex = 1;
    } else if (_playlist.length == 2) {
      if (_queueIndex == 0) {
        _pageIndex = 0;
      } else if (_queueIndex == _queue.length - 1) {
        _pageIndex = 1;
      } else {
        throw Exception('Unexpected error at createPlaylist method of CustomAudioPlayer instance: Type 1');
      }
    } else {
      throw Exception('Unexpected error at createPlaylist method of CustomAudioPlayer instance: Type 2');
    }
  }
}
