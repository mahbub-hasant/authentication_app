import 'package:demo_ui/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  const SubTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
                child: SizedBox(
                  width: 293,
                  child: Column(
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.circularStdBook,
                          color: Color(0xFF797C7B),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              );
  }
}