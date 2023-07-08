import 'package:flutter/material.dart';

import '../utility/colors.dart';
import '../utility/global_var.dart';

// ignore: camel_case_types
class Web_Layout extends StatefulWidget {
  const Web_Layout({super.key});

  @override
  State<Web_Layout> createState() => _Web_LayoutState();
}

class _Web_LayoutState extends State<Web_Layout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: webBackgroundColor,
          centerTitle: false,
          title: Image.asset(
            "assets/PngItem_676474.png",
            color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              color: _page == 0 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              color: _page == 1 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(1),
            ),
            IconButton(
              icon: const Icon(Icons.add_a_photo),
              color: _page == 2 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(2),
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              color: _page == 3 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(3),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: _page == 4 ? primaryColor : secondaryColor,
              onPressed: () => navigationTapped(4),
            )
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: homeScreenItems,
        ));
  }
}
