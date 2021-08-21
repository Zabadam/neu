library neu;

import '../common.dart';

/// A description of the appearance of "curvature" of `Neu` gradients
/// based on the ordering of returned shaded colors.
enum Curvature {
  /// Appears to *really* curve inward, toward the back of the surface,
  /// forming a "cave-like" appearance out of the color shading.
  ///
  /// Shading, when embossed (see [Swell.emboss]), is opposite when comparing
  /// shadows to gradient. When debossed (see [Swell.deboss]) shading of
  /// gradient and shadows match.
  ///
  /// In terms of color, more contrasting shades compared to [concave].
  /// Correlates to, or matches intensity of color shading with,
  /// [Swell.superdeboss].
  superconcave,

  /// Appears to curve inward, toward the back of the surface,
  /// forming a "cave-like" appearance out of the color shading.
  ///
  /// Shading, when embossed (see [Swell.emboss]), is opposite when comparing
  /// shadows to gradient. When debossed (see [Swell.deboss]) shading of
  /// gradient and shadows match.
  ///
  /// In terms of color, smoother fading shades compared to [superconcave].
  /// Correlates to, or matches intensity of color shading with,
  /// [Swell.deboss].
  concave,

  /// No curvature. The gradient will be just the one color with no shading.
  flat,

  /// Appears to curve outward, toward the viewer, forming a round
  /// "bubble-like" appearance out of the color shading.
  ///
  /// Shading for shadows and gradient, when embossed (see [Swell.emboss]),
  /// match each other in orientation. When debossed (see [Swell.deboss]),
  /// shading is opposite when comparing gradient to shadows.
  ///
  /// In terms of color, smoother fading shades compared to [superconvex].
  /// Correlates to, or matches intensity of color shading with,
  /// [Swell.emboss].
  convex,

  /// Appears to *really* curve outward, toward the viewer, forming a round
  /// "bubble-like" appearance out of the color shading.
  ///
  /// Shading for shadows and gradient, when embossed (see [Swell.emboss]),
  /// match each other in orientation. When debossed (see [Swell.deboss]),
  /// shading is opposite when comparing gradient to shadows.
  ///
  /// In terms of color, more contrasting shades compared to [convex].
  /// Correlates to, or matches intensity of color shading with,
  /// [Swell.superemboss].
  superconvex,
}

/// Properties to extend the utility of enum [Curvature].
extension CurvatureUtils on Curvature {
  /// A [Degree] is a simple description of whether something is "standard" or
  /// "super". In terms of [Curvature], either `superconcave` or `superconvex`
  /// returns [Degree.SUPER]. Otherwise returns [Degree.STANDARD].
  Degree get degree {
    switch (this) {
      case Curvature.superconcave:
        return Degree.SUPER;
      case Curvature.concave:
        return Degree.STANDARD;
      case Curvature.flat:
        return Degree.STANDARD;
      case Curvature.convex:
        return Degree.STANDARD;
      case Curvature.superconvex:
        return Degree.SUPER;
    }
  }

  /// Provide a required [color] from which `this` [Curvature] may generate a
  /// corresponding `List<Color>`. The [depth] of the effect is a required
  /// [int]. A lower [depth] fades the object more into its background, while
  /// a larger one will set the object more apart by contrast.
  List<Color> colorList(
    Color color, {
    required Swell swell,
    required int depth,
  }) {
    final _color = swell.toColor(color, depth);

    switch (this) {
      case Curvature.superconcave:
        return [
          _color.withBlack((depth * 1.5).round()),
          _color,
          _color.withWhite((depth * 1.5).round()),
        ];
      case Curvature.concave:
        return [
          _color.withBlack(depth),
          _color,
          _color.withWhite(depth),
        ];
      case Curvature.flat:
        return [_color, _color, _color];
      case Curvature.convex:
        return [
          _color.withWhite(depth),
          _color,
          _color.withBlack(depth),
        ];
      case Curvature.superconvex:
        return [
          _color.withWhite((depth * 1.5).round()),
          _color,
          _color.withBlack((depth * 1.5).round()),
        ];
    }
  }
}
