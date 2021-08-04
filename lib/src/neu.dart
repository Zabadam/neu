/// Neumorphic/Clay implementation
library neu;

import 'common.dart';

/// TODO: Write doc.
///
/// - [Neu.linearGradient]
/// - [Neu.textStyle]
/// - [Neu.boxShadows]
/// - [Neu.boxDecoration]
/// - [Neu.shapeDecoration]
class Neu with Diagnosticable {
// abstract class Neu with Diagnosticable {
  // /// The abstract class [Neu] is not intended to ever have a constructed
  // /// [Object]. [Neu]'s static methods are meant to be accessed directly such
  // /// as `Neu.linearGradient(...)`.
  // ///
  // /// Without this private constructor†, [Neu] would have a no-parameter
  // /// constructor by default. This private constructor is never called
  // /// internally by this package nor is it accessible outside of it, but acts
  // /// to disable the auto-establishment of a constructor by Dart.
  // ///
  // /// † Dart supports named constructors, such as `Neu.named(...)`, in place of
  // /// or in addition to default constructors, such as `Neu(...)`. \
  // /// The library-private identifier `_` makes this named constructor method
  // /// `Neu._(...)` inaccessible outside of this library and will hide any [Neu]
  // /// constructors from generated documentation.
  // Neu._();

  /// TODO: Write doc.
  const Neu({
    required this.color,
    required this.depth,
    this.spread = 7.5,
    this.curvature = Curvature.convex,
    this.swell = Swell.emboss,
    this.borderRadius = BorderRadius.zero,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
  });

  // /// TODO: Write doc.
  // final NeuType type;

  /// TODO: Write doc.
  /// All properties employ `color`.
  final Color color;

  /// TODO: Write doc.
  /// All properties employ `depth`.
  final int depth;

  /// TODO: Write doc.
  /// All properties employ `spread` except for [buildGradient].
  final double spread;

  /// TODO: Write doc.
  /// All properties employ `curvature` except for [buildBoxShadows].
  final Curvature curvature;

  /// TODO: Write doc.
  /// All properties employ `swell`.
  final Swell swell;

  /// TODO: Write doc.
  /// Employed only by [buildBoxDecoration]. Default is [BorderRadius.zero].
  ///
  /// Provide a value such as `BorderRadius.all(Radius.circular(15.0))` for
  /// rounded corners.
  final BorderRadius borderRadius;

  /// TODO: Write doc.
  /// Employed only by [buildShapeDecoration]. Default is
  /// [RoundedRectangleBorder] with a `borderRadius` of `5.0`.
  final ShapeBorder shape;

  // /// TODO: Write doc.
  // final Widget? child;

  /// TODO: Write doc.
  /// Does not consider [spread] nor [shape], [borderRadius].
  Gradient get buildGradient => Neu.linearGradient(
      color: color, curvature: curvature, swell: swell, depth: depth);

  /// TODO: Write doc.
  /// Does not consider [shape], [borderRadius].
  TextStyle get buildTextStyle => Neu.textStyle(
        color: color,
        curvature: curvature,
        swell: swell,
        depth: depth,
        spread: spread,
      );

  /// TODO: Write doc.
  /// Does not consider [curvature] nor [shape], [borderRadius].
  List<BoxShadow> get buildBoxShadows =>
      Neu.boxShadows(color: color, swell: swell, depth: depth, spread: spread);

  /// TODO: Write doc.
  /// Does not consider [shape].
  BoxDecoration get buildBoxDecoration => Neu.boxDecoration(
        color: color,
        curvature: curvature,
        swell: swell,
        depth: depth,
        spread: spread,
        borderRadius: borderRadius,
      );

  /// TODO: Write doc.
  /// Does not consider [borderRadius].
  ShapeDecoration get buildShapeDecoration => Neu.shapeDecoration(
        color: color,
        curvature: curvature,
        swell: swell,
        depth: depth,
        spread: spread,
        shape: shape,
      );

  /// TODO: Write doc.
  static Gradient linearGradient({
    Color color = lightWhite,
    Curvature curvature = Curvature.convex,
    Swell swell = Swell.emboss,
    int depth = 25,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    TileMode tileMode = TileMode.clamp,
    GradientTransform? transform,
  }) =>
      LinearGradient(
        colors: curvature.toColors(
          color.withBlack(depth ~/ swell.divisor(depth: depth) - 1),
          depth: depth,
        ),
        begin: begin,
        end: end,
        tileMode: tileMode,
        transform: transform,
      );

  /// TODO: Write doc.
  ///
  /// The `baseStyle` defaults to an empty `TextStyle` and is offered as a
  /// convenience parameter. This base style will be returned, copied with
  /// "Neu" `color` and `shadows`.
  ///
  /// If a [Rect] `rect` is provided, then a gradient shader is generated
  /// for this `TextStyle` instead of only a color. Also then consider the
  /// local `TextDirection` as it will not be obtained by this static method.
  static TextStyle textStyle({
    TextStyle baseStyle = const TextStyle(),
    Color color = lightWhite,
    Swell swell = Swell.emboss,
    int depth = 25,
    double spread = 5,

    /// FOR GRADIENT:
    Rect? rect,
    Curvature curvature = Curvature.flat,
    TextDirection? textDirection,
  }) {
    final paint = Paint();
    if (rect != null) {
      paint.shader = linearGradient(
        color: color,
        curvature: curvature,
        depth: depth,
        swell: swell,
      ).createShader(rect, textDirection: textDirection);
    }
    final style = baseStyle.copyWith(
      color: color.withBlack(depth ~/ swell.divisor(depth: depth) - 1),
      shadows: boxShadows(
        color: color,
        depth: depth,
        spread: spread,
        swell: swell,
        offsetScalar: 0.6,
      ),
    );
    return (paint.shader == null) ? style : style.copyWith(foreground: paint);
  }

  /// TODO: Write doc.
  static List<BoxShadow> boxShadows({
    Color color = lightWhite,
    Swell swell = Swell.emboss,
    int depth = 25,
    double spread = 7.5,
    double offsetScalar = 1.0,
    double scale = 1.0,
  }) {
    final blur = spread / swell.scalar;
    final offset = spread * offsetScalar;
    final isSwollen = swell.isSwollen;

    final lightOffset = isSwollen ? -offset : offset;
    final light = BoxShadow(
      color: color.withWhite(depth * swell.scalar.toInt()),
      offset: Offset(lightOffset, lightOffset),
      spreadRadius: (swell.scalar - 1),
      blurRadius: blur,
    ).scale(scale);

    return [
      // // color:
      // BoxShadow(
      //   color: color,
      //   spreadRadius: 2.0,
      //   // spreadRadius: (swell.scalar - 1),
      //   blurRadius: blur,
      // ),

      // light:
      if (!isSwollen) light,

      // dark:
      BoxShadow(
        color: color.withBlack((depth * swell.scalar).toInt()),
        offset: Offset(-lightOffset, -lightOffset),
        spreadRadius: (swell.scalar - 1),
        blurRadius: blur,
      ).scale(scale),

      // light:
      if (isSwollen) light,
    ];
  }

  /// TODO: Write doc.
  static BoxDecoration boxDecoration({
    Color color = lightWhite,
    Curvature curvature = Curvature.flat,
    Swell swell = Swell.emboss,
    int depth = 25,
    double spread = 7.5,
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    DecorationImage? image,
    BlendMode? blendMode,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) =>
      BoxDecoration(
        backgroundBlendMode: blendMode,
        image: image,
        shape: shape,
        borderRadius: borderRadius,
        border: border,
        gradient: linearGradient(
          color: color,
          curvature: curvature,
          depth: depth,
          swell: swell,
          begin: begin,
          end: end,
        ),
        boxShadow: boxShadows(
          color: color,
          depth: depth,
          spread: spread,
          swell: swell,
        ),
      );

  /// TODO: Write doc.
  static ShapeDecoration shapeDecoration({
    Color color = lightWhite,
    Curvature curvature = Curvature.flat,
    Swell swell = Swell.emboss,
    int depth = 25,
    double spread = 7.5,
    ShapeBorder shape = const RoundedRectangleBorder(),
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    DecorationImage? image,
  }) =>
      ShapeDecoration(
        shape: shape,
        image: image,
        gradient: linearGradient(
          color: color,
          curvature: curvature,
          swell: swell,
          depth: depth,
          begin: begin,
          end: end,
        ),
        shadows: boxShadows(
          color: color,
          depth: depth,
          spread: spread,
          swell: swell,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(IntProperty('depth', depth))
      ..add(DoubleProperty('spread', spread))
      ..add(DiagnosticsProperty<Curvature>('curvature', curvature))
      ..add(DiagnosticsProperty<Swell>('swell', swell))
      ..add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius))
      ..add(DiagnosticsProperty<ShapeBorder>('shape', shape));
  }
}
