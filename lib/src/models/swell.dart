library neu;

import '../common.dart';

import 'curvature.dart';

/// A representation of a surface's *boss* or how it "swells".
///
/// Consider Braille or a hammered decorative lump on a metal shield to be an
/// example of [emboss].
///
/// Flip that shield or Braille over 180°, and the inset nature
/// of these lumps is now described as [deboss]ed.
enum Swell {
  /// Represents the appearance of a *large* protuberance or lump.
  ///
  /// Considering the front of a credit card, the raised letters and numbers
  /// are an example of embossment.
  superemboss,

  /// Represents the appearance of a protuberance or lump.
  ///
  /// Considering the front of a credit card, the raised letters and numbers
  /// are an example of embossment.
  emboss,

  /// Inset as opposed to protruding.
  ///
  /// May already appear "pressed" in the context of a interactive surface.
  deboss,

  /// *Very* inset as opposed to protruding.
  ///
  /// May already appear "pressed" in the context of a interactive surface.
  superdeboss,
}

extension SwellUtils on Swell {
  Degree get degree {
    switch (this) {
      case Swell.superemboss:
        return Degree.SUPER;
      case Swell.emboss:
        return Degree.STANDARD;
      case Swell.deboss:
        return Degree.STANDARD;
      case Swell.superdeboss:
        return Degree.SUPER;
    }
  }

  /// Whether or not `this` [Swell] would classify as "swollen".
  ///
  /// #### Super/emboss *is* swollen:
  /// - returns `true`
  ///
  /// #### Super/deboss *is not* swollen:
  /// - returns `false`
  bool get isSwollen {
    switch (this) {
      case Swell.superemboss:
        return true;
      case Swell.emboss:
        return true;
      case Swell.deboss:
        return false;
      case Swell.superdeboss:
        return false;
    }
  }

  /// Returns a relatively small scalar as `1.0` or `1.5`.
  double get scalar => (degree == Degree.SUPER) ? 1.5 : 1.0;

  /// Returns a value by which interger division may be acceptable;
  /// that is, a relatively small scalar like `1.0` or `2.0` or the
  /// passed `depth` itself as a neutralizing divisor.
  double divisor({required int depth}) {
    switch (this) {
      case Swell.superemboss:
        // Will actually brighten the color as a negative parameter to
        // `color.withBlack()` in [Neu.linearGradient].
        return -2.5;
      case Swell.emboss:
        // Will actually result in the resultant color of `color.withBlack()`
        // in [Neu.linearGradient] being shaded by `withBlack(1)`. Close.
        return depth.toDouble();
      case Swell.deboss:
        // Has [Neu.linearGradient] shade its `color.withBlack(depth ~/ 2.0)`
        // so its `depth` is halved:
        return 2.0;
      case Swell.superdeboss:
        // Has [Neu.linearGradient] shade its `color.withBlack(depth)`
        // because its `depth` is divided by 1.0:
        return 1.0;
    }
  }

  /// This conversion is useful in the case of [Neu.shapeShadows] where the
  /// offset of appropriately-shaded shadows is not only important, but the
  /// progression of the gradient as well -- considering that
  /// [morph.ShapeShadow] accepts a [Gradient] over a simple color.
  ///
  /// The [degree] serves to transmit "super" status.
  ///
  /// - Super/emboss return convex
  ///   - "super" if `degree` is "super"
  /// - Super/deboss return concave
  ///   - "super" if `degree` is "super"
  Curvature toCurvature(Degree degree) {
    switch (this) {
      case Swell.superemboss:
        return (degree == Degree.SUPER)
            ? Curvature.superconvex
            : Curvature.convex;
      case Swell.emboss:
        return (degree == Degree.SUPER)
            ? Curvature.superconvex
            : Curvature.convex;
      case Swell.deboss:
        return (degree == Degree.SUPER)
            ? Curvature.superconcave
            : Curvature.concave;
      case Swell.superdeboss:
        return (degree == Degree.SUPER)
            ? Curvature.superconcave
            : Curvature.concave;
    }
  }
}
