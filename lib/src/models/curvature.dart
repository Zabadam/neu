library neu;

import '../common.dart';

/// A description of the appearance of "curvature" of `Neu` colors
/// based on the ordering of returned shaded colors.
enum Curvature {
  /// No curvature. The gradient will be just the one color with no shading.
  flat,

  /// Appears to *really* curve inward, toward the back of the surface,
  /// forming a "cave-like" appearance out of the color shading.
  ///
  /// Shading is opposite when comparing shadows to gradient.
  superconcave,

  /// Appears to curve inward, toward the back of the surface,
  /// forming a "cave-like" appearance out of the color shading.
  ///
  /// Shading is opposite when comparing shadows to gradient.
  concave,

  /// Appears to curve outward, toward the viewer, forming a round
  /// "bubble-like" appearance out of the color shading.
  ///
  /// Shading for shadows and gradient match.
  convex,

  /// Appears to *really* curve outward, toward the viewer, forming a round
  /// "bubble-like" appearance out of the color shading.
  ///
  /// Shading for shadows and gradient match.
  superconvex,
}

extension CurvatureUtils on Curvature {
  Degree get _asDegree {
    switch (this) {
      case Curvature.flat:
        return Degree.STANDARD;
      case Curvature.superconcave:
        return Degree.SUPER;
      case Curvature.concave:
        return Degree.STANDARD;
      case Curvature.convex:
        return Degree.STANDARD;
      case Curvature.superconvex:
        return Degree.SUPER;
    }
  }

  List<Color> toColors({
    Color color = lightWhite,
    int depth = 25,
  }) {
    switch (this) {
      case Curvature.flat:
        return [color, color];
      case Curvature.superconcave:
        return [
          color.withBlack((depth * 1.5).round()),
          color,
          color.withWhite((depth * 1.5).round()),
        ];
      case Curvature.concave:
        return [
          color.withBlack(depth),
          color,
          color.withWhite(depth),
        ];
      case Curvature.convex:
        return [
          color.withWhite(depth),
          color,
          color.withBlack(depth),
        ];
      case Curvature.superconvex:
        return [
          color.withWhite((depth * 1.5).round()),
          color,
          color.withBlack((depth * 1.55).round()),
        ];
    }
  }
}
