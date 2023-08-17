import 'package:flutter/material.dart';

class HostDescriptionText extends StatelessWidget {
  final String img;
  final String det;
  const HostDescriptionText({super.key, required this.img, required this.det});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 18),
      child: Row(
        children: [
          Image.asset(
            img,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              det,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
