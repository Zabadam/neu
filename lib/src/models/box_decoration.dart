library neu;

import '../common.dart';

import '../neu.dart';
import 'curvature.dart';
import 'swell.dart';

class NeuBoxDecoration extends BoxDecoration {
  const NeuBoxDecoration({
    Color color = lightWhite,
    this.curvature = Curvature.flat,
    this.swell = Swell.emboss,
    this.depth = 25,
    this.spread = 7.5,
    this.scaleFactor = 1.0,
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    DecorationImage? image,
    BlendMode? blendMode,
    // AlignmentGeometry gradientBegin = Alignment.topLeft,
    // AlignmentGeometry gradientEnd = Alignment.bottomRight,
  }) : super(
          backgroundBlendMode: blendMode,
          border: border,
          borderRadius: borderRadius,
          color: color,
          image: image,
          shape: shape,
        );

  final Curvature curvature;
  final Swell swell;
  final int depth;
  final double spread, scaleFactor;

  @override
  List<BoxShadow> get boxShadow => Neu.boxShadows(
        color: color!, // non-nullable param of `NeuBoxDecoration`
        depth: depth,
        spread: spread,
        swell: swell,
        scale: scaleFactor,
      );

  @override
  Gradient get gradient => Neu.linearGradient(
        color: color!,
        curvature: curvature,
        depth: depth,
        swell: swell,
      );
}
