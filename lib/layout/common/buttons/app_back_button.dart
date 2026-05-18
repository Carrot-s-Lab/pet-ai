import 'package:pet_ai_project/core/extensions/color.dart';
import 'package:pet_ai_project/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../generated/assets.dart';
import '../color/app_color.dart';
import '../widgets/highlight_on_tap.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onTap, this.size});

  final void Function()? onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 40,
      height: size ?? 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfacePrimary,
      ),
      child: HighlightOnTap(
        onTap: onTap ?? () => appRouter.pop(context),
        child: Center(
          child: SvgPicture.asset(
            Assets.iconsBack,
            colorFilter: AppColors.textPrimary.toColorFilter(),
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
