import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../style/color_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorManager.white,
      ),
    );
  }
}
