class MusicData {
  final String name;
  final String artist;
  final String? coverArtUrl;
  final String musicUrl;
  bool isFavorited;
  final Duration duration;

  MusicData(this.musicUrl,{
    required this.name,
    required this.artist,
    this.coverArtUrl,
    required this.duration,
    this.isFavorited = false,
  });

}

final List<MusicData> queue = [
  MusicData('hcs.mp3',
    name: 'Siren',
    artist: 'Hayko Cepkin',
    coverArtUrl: 'assets/hcs.jpg',
    duration: const Duration(minutes: 4, seconds: 7),
    isFavorited: true,
  ),
  MusicData('rmt.mp3',
    name: 'Mein Teil',
    artist: 'Rammstein',
    coverArtUrl: 'assets/rmt.jpg',
    duration: const Duration(minutes: 4, seconds: 20),
  ),
  MusicData('md.mp3',
    name: 'Deprem',
    artist: 'Malt',
    duration: const Duration(minutes: 3, seconds: 32),
  ),
  MusicData('sfbtt.mp3',
    name: 'Teslim Tesellüm',
    artist: 'Son Feci Bisiklet',
    duration: const Duration(minutes: 4, seconds: 10),
    isFavorited: true,
  ),
  MusicData('rhcpdn.mp3',
    name: 'Dark Necessities',
    artist: 'Red Hot Chili Peppers',
    duration: const Duration(minutes: 5, seconds: 2),
  ),
  MusicData('lpbth.mp3',
    name: 'Breaking The Habit',
    artist: 'Linkin Park',
    coverArtUrl: 'assets/lpbth.jpg',
    duration: const Duration(minutes: 3, seconds: 16),
    isFavorited: true,
  ),
];