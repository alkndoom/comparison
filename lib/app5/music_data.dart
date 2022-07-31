
class MusicData {
  final String name;
  final String artist;
  final String? coverArtUrl;
  final String musicUrl;
  MusicData(this.musicUrl,{
    required this.name,
    required this.artist,
    this.coverArtUrl,
  });
}

List<MusicData> source = [
  MusicData('hcs.mp3',
    name: 'Siren',
    artist: 'Hayko Cepkin',
    coverArtUrl: 'assets/hcs.jpg',
  ),
  MusicData('lpbth.mp3',
    name: 'Breaking The Habit',
    artist: 'Linkin Park',
    coverArtUrl: 'assets/lpbth.jpg',
  ),
  MusicData('rmt.mp3',
    name: 'Mein Teil',
    artist: 'Rammstein',
    coverArtUrl: 'assets/rmt.jpg',
  ),
  MusicData('md.mp3',
    name: 'Deprem',
    artist: 'Malt',
  ),
  MusicData('sfbtt.mp3',
    name: 'Teslim Tesellüm',
    artist: 'Son Feci Bisiklet',
  ),
  MusicData('rhcpdn.mp3',
    name: 'Dark Necessities',
    artist: 'Red Hot Chili Peppers',
  ),
];