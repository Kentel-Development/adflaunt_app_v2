import 'package:flutter/material.dart';

class AdSpecs extends StatelessWidget {
  const AdSpecs({
    super.key,
    required this.adSpecs,
  });

  final List<String> adSpecs;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: -8,
        children: adSpecs
            .map(
              (e) => Chip(
                label: Text(
                  e,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                backgroundColor: Color.fromRGBO(224, 224, 227, 1),
              ),
            )
            .toList(),
      ),
    );
  }
}
