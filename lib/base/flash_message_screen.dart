import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_snackbar_content.dart';

class FlashMessageScreen extends StatelessWidget {
  const FlashMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackBarContent(errorText: "That Email Address is already in use! Please try with a different one",),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        },
        child: const Text("Show Message"),
      )),
    );
  }
}
