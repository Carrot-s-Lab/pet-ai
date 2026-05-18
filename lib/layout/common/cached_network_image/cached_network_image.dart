import 'package:pet_ai_project/core/extensions/string.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class BaseCachedNetworkImage extends StatelessWidget {
  const BaseCachedNetworkImage(
    this.url, {
    super.key,
    this.fit,
    this.borderRadius,
    this.useAbsoluteUrl = false,
    this.width,
    this.height,
  });

  final String url;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final bool useAbsoluteUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // if (url.isEmpty) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: useAbsoluteUrl ? url : url.toImageUrl(),
        fit: fit ?? BoxFit.cover,
        errorWidget: (context, _, __) {
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
