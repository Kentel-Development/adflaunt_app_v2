enum PaddingEnum {
  small,
  medium,
  large,
}

class PaddingConstants {
  static const double smallPadding = 8;
  static const double mediumPadding = 16;
  static const double largePadding = 25;

  static double getPadding(PaddingEnum padding) {
    switch (padding) {
      case PaddingEnum.small:
        return smallPadding;
      case PaddingEnum.medium:
        return mediumPadding;
      case PaddingEnum.large:
        return largePadding;
    }
  }
}
