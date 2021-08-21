import 'package:flutter/painting.dart';

import 'package:spectrum/spectrum.dart' show Shading;

export 'package:flutter/foundation.dart';
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart';
export 'package:flutter/painting.dart';
export 'package:flutter/services.dart';
export 'package:flutter/widgets.dart';

/// TODO: Consider making more utilization out of Spectrum or duplicating its usage with the simple methods found in [Shading]. \
export 'package:spectrum/spectrum.dart' show Shading;

export 'models/curvature.dart';
export 'models/degree.dart';
export 'models/swell.dart';
export 'models/text.dart';

///     const lightWhite = Color(0xFFE0E0E0);
const lightWhite = Color(0xFFE0E0E0);

///     const defaultDepth = 25;
const defaultDepth = 25;

///     const defaultSpread = 7.5;
const defaultSpread = 7.5;

///     var defaultDepthMultiplier = 1.3;
const defaultDepthMultiplier = 1.3;

///     var defaultSpreadMultiplier = 0.4;
const defaultSpreadMultiplier = 0.4;

///     const defaultLightSource = Alignment.topLeft;
const defaultLightSource = Alignment.topLeft;

///     const defaultDuration = Duration(milliseconds: 1200);
const defaultDuration = Duration(milliseconds: 1200);

///     const defaultRadius = BorderRadius.all(Radius.circular(5.0));
const defaultRadius = BorderRadius.all(Radius.circular(5.0));

// ignore: lines_longer_than_80_chars
///     RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3.0)));
const defaultShape = RoundedRectangleBorder(borderRadius: defaultRadius);
