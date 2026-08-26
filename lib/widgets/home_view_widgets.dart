import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/chevron.left.png',
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                Image.asset(
                  'assets/icons/leftitle.png',
                  width: 130,
                  height: 40,
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icons/rightitle.png',
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}