library neu;

import '../common.dart';

/// A representation of a surface's *boss* or how it "swells".
///
/// Consider Braille or a hammered decorative lump on a metal shield to be an
/// example of [emboss].
///
/// Flip that shield or Braille over 180°, and the inset nature
/// of these lumps is now described as [deboss]ed.
enum Swell {
  /// *Very* inset as opposed to protruding.
  ///
  /// May already appear "pressed" in the context of a interactive surface.
  ///
  /// In terms of color, more contrasting shades compared to [deboss].
  /// Correlates to, or matches intensity of color shading with,
  /// [Curvature.superconcave].
  superdeboss,

  /// Inset as opposed to protruding.
  ///
  /// May already appear "pressed" in the context of a interactive surface.
  ///
  /// In terms of color, smoother fading shades compared to [deboss].
  /// Correlates to, or matches intensity of color shading with,
  /// [Curvature.concave].
  deboss,

  /// Represents the appearance of a protuberance or lump.
  ///
  /// Considering the front of a credit card, the raised letters and numbers
  /// are an example of embossment.
  ///
  /// In terms of color, smoother fading shades compared to [emboss].
  /// Correlates to, or matches intensity of color shading with,
  /// [Curvature.convex].
  emboss,

  /// Represents the appearance of a *large* protuberance or lump.
  ///
  /// Considering the front of a credit card, the raised letters and numbers
  /// are an example of embossment.
  ///
  /// In terms of color, more contrasting shades compared to [emboss].
  /// Correlates to, or matches intensity of color shading with,
  /// [Curvature.superconvex].
  superemboss,
}

/// Properties to extend the utility of enum [Swell].
extension SwellUtils on Swell {
  /// A [Degree] is a simple description of whether something is "standard" or
  /// "super". In terms of [Swell], either `superemboss` or `superdeboss`
  /// returns [Degree.SUPER]. Otherwise returns [Degree.STANDARD].
  Degree get degree {
    switch (this) {
      case Swell.superdeboss:
        return Degree.SUPER;
      case Swell.deboss:
        return Degree.STANDARD;
      case Swell.emboss:
        return Degree.STANDARD;
      case Swell.superemboss:
        return Degree.SUPER;
    }
  }

  /// Whether or not `this` [Swell] would classify as "swollen".
  ///
  /// Emboss, superemboss *is* swollen: returns `true`.
  ///
  /// Deboss, superdeboss *is not* swollen: returns `false`.
  bool get isSwollen {
    switch (this) {
      case Swell.superdeboss:
        return false;
      case Swell.deboss:
        return false;
      case Swell.emboss:
        return true;
      case Swell.superemboss:
        return true;
    }
  }

  /// Returns a relatively small scalar, either `1.0` or `1.5`, considering
  /// [degree].
  double get scalar => (degree == Degree.SUPER) ? 1.5 : 1.0;

  /// Returns a value by which interger division may be acceptable;
  /// that is, a relatively small scalar like `1.0` or `2.0` or the
  /// passed `depth` itself as a neutralizing divisor.
  double divisor(int depth) {
    switch (this) {
      case Swell.superdeboss:
        // Has [Neu.linearGradient] darken its `color.withBlack(depth ~/ 1.0)`
        // which provides a darker, inset-appearing color:
        return 1.0;
      case Swell.deboss:
        // Has [Neu.linearGradient] shade its `color.withBlack(depth ~/ 2.0)`
        // so its darkened by a value corresponding to `depth` but at half the
        // strength of `Swell.superdeboss`:
        return 2.0;
      case Swell.emboss:
        // Will actually result in the resultant color of `color.withBlack()`
        // in [Neu.linearGradient] being shaded by `(depth / depth) - 1`,
        // resulting in the color itself. This is the self-neutralizing
        // (and [Neu]-default) choice.
        return depth.toDouble();
      case Swell.superemboss:
        // Will actually brighten the color as a negative parameter to
        // `color.withBlack()` in [Neu.linearGradient] as `depth / -2.5`.
        return -2.5;
    }
  }

  /// Provide a required [color] from which `this` [Swell] may generate a
  /// corresponding shaded [Color]. The [depth] of the effect is a required
  /// [int]. A lower [depth] fades the object more into its background, while
  /// a larger one will set the object more apart by contrast.
  ///
  /// [Swell.emboss] returns `color.withBlack(0)`, or itself.
  /// Superemboss will use a negative value to brighten the base color,
  /// while super/deboss use divisors of `1.0` or `2.0` to darken the
  /// base color.
  Color toColor(Color color, int depth) => color.withBlack(
      (depth / divisor(depth) - (this == Swell.emboss ? 1 : 0)).round());

  // /// This conversion is useful in the case of [ GRADIENT SHADOWS ] where the
  // /// offset of appropriately-shaded shadows is not only important, but the
  // /// progression of the gradient as well -- considering that
  // /// [ GRADIENT SHADOWS ] accept a [Gradient] over a simple [Color].
  // ///
  // /// The [degree] serves to transmit "super" status.
  // ///
  // /// - Super/emboss return convex
  // ///   - "super" if `degree` is "super"
  // /// - Super/deboss return concave
  // ///   - "super" if `degree` is "super"
  // Curvature toCurvature(Degree degree) {
  //   switch (this) {
  //     case Swell.superdeboss:
  //       return (degree == Degree.SUPER)
  //           ? Curvature.superconcave
  //           : Curvature.concave;
  //     case Swell.deboss:
  //       return (degree == Degree.SUPER)
  //           ? Curvature.superconcave
  //           : Curvature.concave;
  //     case Swell.emboss:
  //       return (degree == Degree.SUPER)
  //           ? Curvature.superconvex
  //           : Curvature.convex;
  //     case Swell.superemboss:
  //       return (degree == Degree.SUPER)
  //           ? Curvature.superconvex
  //           : Curvature.convex;
  //   }
  // }
}
