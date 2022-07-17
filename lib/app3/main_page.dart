import 'package:flutter/material.dart';
import 'overlay_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa AppBar'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Center(
          child: OverlayButtongy(),
        ),
      ),
    );
  }
}

class OverlayButtongy extends StatefulWidget {
  const OverlayButtongy({Key? key}) : super(key: key);

  @override
  State<OverlayButtongy> createState() => _OverlayButtongyState();
}

class _OverlayButtongyState extends State<OverlayButtongy> {
  //########################################
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  //########################################

  bool isMenuOpen = false;
  final layerLink = LayerLink();
  OverlayEntry? entry;

  void hideOverlay() {
    entry?.remove();
    entry = null;
    isMenuOpen = !isMenuOpen;
  }

  void showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: 150,
        height: 100,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(-55, size.height + 7),
          child: const OverlayPage(),
        ),
      ),
    );

    overlay.insert(entry!);

    isMenuOpen = !isMenuOpen;
  }

  //########################################

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (!isMenuOpen) {
            showOverlay();
          } else {
            hideOverlay();
          }
        },
        child: Ink(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.apps_outlined, color: Colors.white,),
        ),
      ),
    );
  }
}