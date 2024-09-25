import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//App Loading
class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // App Loading indicator
    return const SpinKitSquareCircle(size: 40, color: Colors.pink);
  }
}

//Compress Progress Indicator Loading
class CompressLoading extends StatelessWidget {
  const CompressLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitPouringHourGlass(color: Colors.pink);
  }
}
