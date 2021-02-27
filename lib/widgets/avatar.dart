import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/utils/utils.dart';
import 'package:transparent_image/transparent_image.dart';

class AvatarSize {
  static const double small = 36;
  static const double normal = 46;
  static const double large = 60;
}

/// 通用头像组件
/// [image] 头像链接或资源地址
/// [size] 头像大小，默认是[AvatarSize.normal]
/// [bordered] 头像是否有白边框，默认为[false]
/// [hasShadow] 头像是否有阴影，默认为[false]
class Avatar extends StatelessWidget {
  final double size;
  final String? image;
  final bool bordered;
  final double borderWidth;
  final Color borderColor;
  final bool hasShadow;
  final Widget? topRight;
  final double? offsetTop;
  final double? offsetRight;

  Avatar({
    Key? key,
    this.image,
    this.topRight,
    this.bordered = false,
    this.hasShadow = false,
    this.borderWidth = 3,
    this.offsetTop = 0,
    this.offsetRight = 0,
    this.size = AvatarSize.normal,
    this.borderColor = CupertinoColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: bordered
            ? Border.all(
                width: borderWidth,
                color: borderColor,
              )
            : null,
        boxShadow: _buildShadow(),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildAvatar(),
          Positioned(
            top: offsetTop,
            right: offsetRight,
            child: topRight ?? Container(),
          ),
        ],
      ),
    );
  }

  List<BoxShadow> _buildShadow() {
    if (hasShadow) {
      return [
        BoxShadow(
          color: Color(0x30000000),
          offset: Offset(0, 1),
          blurRadius: 6,
        ),
      ];
    }

    return [
      BoxShadow(
        color: Color(0x10000000),
        offset: Offset(0, 1),
        blurRadius: 2,
      ),
    ];
  }

  Widget _buildAvatar() {
    if (image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: image!,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      ),
      child: null,
    );
  }
}
