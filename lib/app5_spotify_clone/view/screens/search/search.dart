import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final ScrollController scrollController;
  final String? tag;

  const Search({
    Key? key,
    required this.scrollController,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Search',
        ),
      ),
    );
  }
}
