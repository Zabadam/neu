import 'package:flutter/painting.dart' show Color;

export 'package:flutter/foundation.dart';
export 'package:flutter/painting.dart';
export 'package:flutter/widgets.dart';

// TODO: Consider making more utilization out of Spectrum or duplicating its usage with the simple methods found in [Shading] \
export 'package:spectrum/spectrum.dart' show Shading;

export 'models/curvature.dart';
export 'models/swell.dart';

///     const lightWhite = Color(0xFFE0E0E0);
const lightWhite = Color(0xFFE0E0E0);

///     enum Degree { STANDARD, SUPER }
enum Degree {
  /// Not "super...", such as `concave` or `deboss`.
  // ignore: constant_identifier_names
  STANDARD,

  /// Super meaning "extra", such as `superconvex` or `superemboss`.
  // ignore: constant_identifier_names
  SUPER,
}
