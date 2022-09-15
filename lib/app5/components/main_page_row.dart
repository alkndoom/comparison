import 'package:flutter/material.dart';
import 'package:comparison/app5/sizes.dart';

class MainPageRow extends StatefulWidget {
  final String? tag;
  final Widget title;
  final List children;
  final List? actions;
  final double whiteSpace;
  final double spaceBetweenTextAndRow;
  final double titlePadding;
  final double height;

  const MainPageRow({
    Key? key,
    this.tag,
    required this.title,
    required this.children,
    this.actions,
    this.whiteSpace = Sizes.mainPageRowWhiteSpace,
    this.spaceBetweenTextAndRow = Sizes.mainPageRowSpaceBetweenTextAndRow,
    this.titlePadding = Sizes.mainPageRowTitlePadding,
    this.height = Sizes.mainPageRowSlideHeight,
  }) : super(key: key);

  @override
  State<MainPageRow> createState() => _MainPageRowState();
}

class _MainPageRowState extends State<MainPageRow> {
  @override
  Widget build(BuildContext context) {
    List childrenToRender = [
      SizedBox(width: widget.whiteSpace),
      ...widget.children,
      SizedBox(width: widget.whiteSpace),
    ];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: widget.titlePadding,
              right: widget.titlePadding,
              bottom: widget.spaceBetweenTextAndRow),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: widget.title),
              ...?widget.actions,
            ],
          ),
        ),
        Container(
          height: widget.height,
          child: ListView.builder(
            key: widget.tag != null ? PageStorageKey(widget.tag) : null,
            scrollDirection: Axis.horizontal,
            itemCount: childrenToRender.length,
            itemBuilder: (context, index) => childrenToRender[index],
          ),
        ),
      ],
    );
  }
}

class MainPageRowItemCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color coverColor;
  final bool centerText;
  final double coverSize;
  final double textSize;
  final double spaceBetweenCards;
  final double spaceBetweenTextLines;
  final double spaceBetweenTextAndCover;
  final TextStyle? textStyle;

  const MainPageRowItemCard({
    Key? key,
    required this.text,
    required this.onTap,
    this.coverColor = const Color(0xFF333333),
    this.coverSize = Sizes.rowItemCardCoverSize,
    this.textSize = Sizes.rowItemCardTextSize,
    this.spaceBetweenCards = Sizes.rowItemCardSpaceBetweenCards,
    this.spaceBetweenTextLines = Sizes.rowItemCardSpaceBetweenTextLines,
    this.spaceBetweenTextAndCover = Sizes.rowItemCardSpaceBetweenTextAndCover,
    this.centerText = false,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spaceBetweenCards / 2),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          width: coverSize,
          height: coverSize + spaceBetweenTextAndCover + 2 * spaceBetweenTextLines * textSize,
          child: Column(
            children: [
              Container(
                width: coverSize,
                height: coverSize,
                color: coverColor,
                child: Icon(
                  Icons.music_note,
                  color: Colors.grey,
                  size: coverSize / 3,
                ),
              ),
              SizedBox(height: spaceBetweenTextAndCover),
              Row(
                mainAxisAlignment: centerText ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      text,
                      style: textStyle ??
                          TextStyle(
                            fontSize: textSize,
                            color: Colors.grey,
                            height: spaceBetweenTextLines,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: centerText ? TextAlign.center : TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
