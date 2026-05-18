import 'package:flutter/material.dart';
import '../../../core/utils/global.dart';

class DialogFrame extends StatelessWidget {
  const DialogFrame({super.key, required this.child, this.didCloseDialog});

  final Widget child;
  final void Function()? didCloseDialog;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                width: sWIDTH,
                height: sHEIGHT,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // if (didCloseDialog != null) {
                    //   didCloseDialog!();
                    // }
                    didCloseDialog != null ? didCloseDialog!() : () {};
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                width: sWIDTH,
                height: sHEIGHT,
                child: Column(
                  children: [
                    const Spacer(),
                    child,
                    const Spacer(),
                  ],
                ))
          ],
        ));
  }
}
