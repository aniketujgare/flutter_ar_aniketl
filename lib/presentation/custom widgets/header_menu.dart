// ignore: file_names
import 'package:flutter/material.dart';

class HeaderMenu extends StatefulWidget {
  const HeaderMenu({super.key});

  @override
  State<HeaderMenu> createState() => _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/images/PNG Icons/CustomButtons001.png',
            height: MediaQuery.of(context).size.height * 0.13,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Text(
          "Sara",
          style: TextStyle(
              color: const Color.fromRGBO(79, 58, 156, 1),
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontFamily: 'UniformRounded'),
        ),
      ],
    );
  }
}
