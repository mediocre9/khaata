import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:khata/routes/route_generator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<PageViewModel> pages = [
    PageViewModel(
        title: "Introduction 1",
        // image: Image.asset('assets/finance.json'),
        body: "Description"),
    PageViewModel(
        title: "Introduction 2",
        // image: Image.asset('assets/currency_anim.json'),
        body: "Description"),
    PageViewModel(
        title: "Inroduction 3",
        // image: Image.asset('assets/currency_anim.json'),
        body: "Description"),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      isTopSafeArea: true,
      showNextButton: true,
      showDoneButton: true,
      showBackButton: true,
      done: const Text("Done"),
      back: const Text("Back"),
      next: const Text("Next"),
      onDone: () {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.kManageUserScreen, (route) => false);
      },
    );
  }
}
