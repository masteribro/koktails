import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.green,
        size: 30,
      ),
    );
  }
}
