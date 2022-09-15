import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  final ScrollController scrollController;
  final String? tag;

  const Library({
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
          'Library',
        ),
      ),
    );
  }
}