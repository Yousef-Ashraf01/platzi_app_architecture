import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.light = false});

  final bool light;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 96,
    height: 96,
    child: Image.asset('assets/images/logo_shop.png'),
  );
}
