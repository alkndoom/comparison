import 'package:comparison/app5_spotify_clone/view/components/custom_icon_button.dart';
import 'package:comparison/app5_spotify_clone/view/components/main_page_row.dart';
import 'package:comparison/app5_spotify_clone/view/providers/custom_audio_player_provider.dart';
import 'package:comparison/app5_spotify_clone/view/screens/home/home_data.dart';
import 'package:comparison/app5_spotify_clone/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final ScrollController scrollController;
  final String? tag;

  const Home({
    Key? key,
    required this.scrollController,
    this.tag,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToRender = [
      Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
        child: MainPageRow(
          height: Sizes.mainPageRowSlideHeightFirst,
          spaceBetweenTextAndRow: Sizes.mainPageRowSpaceBetweenTextAndRowFirst,
          titlePadding: Sizes.mainPageRowTitlePaddingFirst,
          whiteSpace: Sizes.mainPageRowWhiteSpaceFirst,
          tag: 'Recently played',
          title: const Text(
            'Recently played',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.mainPageRowTextSizeFirst,
            ),
          ),
          actions: [
            CustomIconButton(
              iconData: Icons.notifications_none,
              onPressed: () {},
            ),
            const SizedBox(width: Sizes.mainPageRowActionsSize / 2),
            CustomIconButton(
              iconData: Icons.restore,
              onPressed: () {},
            ),
            const SizedBox(width: Sizes.mainPageRowActionsSize / 2),
            CustomIconButton(
              iconData: Icons.settings_outlined,
              onPressed: () {},
            ),
          ],
          children: recentlyPlayed
              .map((r) => MainPageRowItemCard(
            onTap: () async {
              await Provider.of<CustomAudioPlayerProvider>(context, listen: false).start(r['playlist'], 3);
            },
            coverSize: Sizes.rowItemCardCoverSizeFirst,
            spaceBetweenCards: Sizes.rowItemCardSpaceBetweenCardsFirst,
            spaceBetweenTextAndCover: Sizes.rowItemCardSpaceBetweenTextAndCoverFirst,
            centerText: r['centerText'],
            text: r['text'],
            textStyle: const TextStyle(
              fontSize: Sizes.rowItemCardTextSizeFirst,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: Sizes.rowItemCardSpaceBetweenTextLinesFirst,
            ),
          ))
              .toList(),
        ),
      ),
      ...mainPageData
          .map((e) => Padding(
        padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
        child: MainPageRow(
          tag: e['titleText'],
          title: Text(
            e['titleText'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.mainPageRowTextSize,
            ),
          ),
          children: e['children']
              .map(
                (r) => MainPageRowItemCard(
              onTap: () {},
              centerText: r['centerText'],
              text: r['text'],
            ),
          )
              .toList(),
        ),
      ))
          .toList(),
    ];
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.3, 0.65],
          colors: [Color(0xFF3F4646), Color(0xFF30d5c8), Color(0xFF121212)],
        ),
      ),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          key: widget.tag != null ? PageStorageKey(widget.tag) : null,
          controller: widget.scrollController,
          itemCount: widgetsToRender.length,
          itemBuilder: (context, index) => widgetsToRender[index],
        ),
      ),
    );
  }
}

