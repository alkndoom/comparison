class MusicData {
  final String name;
  final String artist;
  final String? coverArtUrl;
  final String musicUrl;
  bool isFavorited;

  MusicData(this.musicUrl,{
    required this.name,
    required this.artist,
    this.coverArtUrl,
    this.isFavorited = false,
  });

}

final List<MusicData> queue1 = [
  MusicData('hcs.mp3',
    name: 'Siren',
    artist: 'Hayko Cepkin',
    coverArtUrl: 'assets/hcs.jpg',
    isFavorited: true,
  ),
  MusicData('lpbth.mp3',
    name: 'Breaking The Habit',
    artist: 'Linkin Park',
    coverArtUrl: 'assets/lpbth.jpg',
    isFavorited: true,
  ),
  MusicData('rmt.mp3',
    name: 'Mein Teil',
    artist: 'Rammstein',
    coverArtUrl: 'assets/rmt.jpg',
  ),
  MusicData('md.mp3',
    name: 'Deprem',
    artist: 'Malt',
    coverArtUrl: 'assets/md.jpg',
  ),
  MusicData('sfbtt.mp3',
    name: 'Teslim Tesellüm',
    artist: 'Son Feci Bisiklet',
    coverArtUrl: 'assets/sfbtt.jpg',
    isFavorited: true,
  ),
  MusicData('rhcpdn.mp3',
    name: 'Dark Necessities',
    artist: 'Red Hot Chili Peppers',
    coverArtUrl: 'assets/rhcpdn.jpg',
  ),
  MusicData('monke.mp3',
    name: 'monke',
    artist: 'Master Oogway',
    isFavorited: true,
  ),
];



final List<MusicData> queue2 = [
  MusicData('csj5.mp3',
    name: 'Concrete Schoolyard',
    artist: 'Jurassic 5',
    coverArtUrl: 'assets/csj.jpg',
    isFavorited: true,
  ),
  MusicData('dgp.mp3',
    name: "God's Plan",
    artist: 'Drake',
    coverArtUrl: 'assets/ds.jpg',
    isFavorited: true,
  ),
  MusicData('dind.mp3',
    name: 'Indestructable',
    artist: 'Disturbed',
    coverArtUrl: 'assets/dind.jpg',
  ),
  MusicData('dstr.mp3',
    name: 'Stricken',
    artist: 'Disturbed',
    coverArtUrl: 'assets/dttf.jpg',
  ),
  MusicData('hcbe.mp3',
    name: 'Bertaraf Et',
    artist: 'Hayko Cepkin',
    coverArtUrl: 'assets/hcs.jpg',
  ),
  MusicData('tsbs.mp3',
    name: 'Blank Space',
    artist: 'Taylor Swift',
    coverArtUrl: 'assets/19879.jpg',
  ),
  MusicData('tsikywt.mp3',
    name: 'I Knew You Were Trouble',
    artist: 'Taylor Swift',
    coverArtUrl: 'assets/tsr.jpg',
  ),
];