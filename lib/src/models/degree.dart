/// Consider defining [Degree] in `common.dart` instead of exporting it, as the
/// end user does not really need it.
///
/// It is exported for now as [CurvatureUtils] and [SwellUtils] each have a
/// public `Degree degree` getter.
library neu;

import '../common.dart';

///      { STANDARD, SUPER }
///      | normal, extreme |
///     | smooth, contrasted |
///
/// ---
///
/// `STANDARD` [Curvature]s:
/// - [Curvature.flat], [Curvature.concave], [Curvature.convex]
///
/// `STANDARD` [Swell]s:
/// - [Swell.deboss], [Swell.emboss]
///
/// ---
///
/// `SUPER` [Curvature]s:
/// - [Curvature.superconcave], [Curvature.superconvex]
///
/// `SUPER` [Swell]s:
/// - [Swell.superdeboss], [Swell.superemboss]
enum Degree {
  /// Not "super", as literally the prefix is absent. Anything that cannot be
  /// classified as [SUPER] falls under the description of [STANDARD].
  ///
  /// `STANDARD` [Curvature]s:
  /// - [Curvature.flat], [Curvature.concave], [Curvature.convex]
  ///
  /// `STANDARD` [Swell]s:
  /// - [Swell.deboss], [Swell.emboss]
  //
  // ignore: constant_identifier_names
  STANDARD,

  /// Super meaning "extra". As a prefix, it is attached to the beginning of
  /// something described as [STANDARD] otherwise.
  ///
  /// `SUPER` [Curvature]s:
  /// - [Curvature.superconcave], [Curvature.superconvex]
  ///
  /// `SUPER` [Swell]s:
  /// - [Swell.superdeboss], [Swell.superemboss]
  //
  // (`super` is a keyword.)
  // ignore: constant_identifier_names
  SUPER,
}
