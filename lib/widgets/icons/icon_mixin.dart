import 'package:flutter/widgets.dart';

class IconMixin {
  Size getImageSize({double width, double height, Size originalSize}) {
    if (width == null && height == null) {
      return originalSize;
    } else if (width != null && height == null) {
      height = originalSize.height * (width / originalSize.width);
      return Size(width, height);
    } else if (width == null && height != null) {
      width = originalSize.width * (height / originalSize.height);
      return Size(width, height);
    } else {
      double aspect = width / height;
      double originalAspect = originalSize.width / originalSize.height;
      if (originalAspect < aspect) {
        //Scale base height
        return Size(
          originalSize.width * (height / originalSize.height),
          height,
        );
      } else {
        return Size(
          width,
          originalSize.height * (width / originalSize.width),
        );
      }
    }
  }

  double getWidth({double width, double height, Size originalSize}) {
    return getImageSize(
            width: width, height: height, originalSize: originalSize)
        .width;
  }

  double getHeight({double width, double height, Size originalSize}) {
    return getImageSize(
            width: width, height: height, originalSize: originalSize)
        .height;
  }
}
