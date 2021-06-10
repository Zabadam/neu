/// Neumorphic/Clay implementation
library neu;

import 'common.dart';
import 'models/curvature.dart';
import 'models/swell.dart';

// import 'package:animated_styled_widget/animated_styled_widget.dart' as morph;

// import 'goodies.dart';

/// - [Neu.linearGradient]
/// - [Neu.boxShadows]
//   - [Neu.shapeShadows]
/// - [Neu.boxDecoration]
/// - [Neu.shapeDecoration]
abstract class Neu {
  static Gradient linearGradient({
    Color color = lightWhite,
    Curvature curvature = Curvature.convex,
    Swell swell = Swell.emboss,
    int depth = 25,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) =>
      LinearGradient(
        colors: curvature.toColors(
          color:
              color.withBlack(depth ~/ swell.toShadeDivisor(depth: depth) - 1),
          depth: depth,
        ),
        begin: begin,
        end: end,
      );

  /// If a [Rect] `rect` is provided, then a gradient shader is generated
  /// for this `TextStyle` instead of only a color. Also then consider the
  /// local `TextDirection` as it will not be obtained by this static method.
  ///
  /// The `baseStyle` defaults to an empty `TextStyle` and is offered as a
  /// convenience parameter. This base style will be returned, copied with
  /// the new color and shadows.
  static TextStyle textStyle({
    TextStyle baseStyle = const TextStyle(),
    Color color = lightWhite,
    Swell swell = Swell.emboss,
    int depth = 25,
    double spread = 5,
    // FOR GRADIENT:
    Curvature curvature = Curvature.flat,
    Rect? rect,
    // TextDirection? textDirection,
  }) {
    final paint = Paint();
    if (rect != null) {
      paint.shader = linearGradient(
        color: color,
        curvature: curvature,
        depth: depth,
        swell: swell,
      ).createShader(rect /* textDirection: textDirection */);
    }
    final style = baseStyle.copyWith(
      color: color.withBlack(depth ~/ swell.toShadeDivisor(depth: depth) - 1),
      shadows: boxShadows(
        color: color,
        depth: depth,
        spread: spread,
        swell: swell,
        offsetScalar: 0.5,
      ),
    );
    return (paint.shader == null) ? style : style.copyWith(foreground: paint);
  }

  static List<BoxShadow> boxShadows({
    Color color = lightWhite,
    Swell swell = Swell.emboss,
    int depth = 25,
    double spread = 7.5,
    double offsetScalar = 1.0,
    double scale = 1.0,
  }) {
    final blur = spread / swell.asScalar;
    final offset = spread * offsetScalar;

    final isSwollen = swell.asBool;
    final lightOffset = isSwollen ? -offset : offset;
    final light = BoxShadow(
      color: color.withWhite(depth * swell.asScalar.toInt()),
      offset: Offset(lightOffset, lightOffset),
      spreadRadius: (swell.asScalar - 1),
      blurRadius: blur,
    ).scale(scale);

    return [
      // BoxShadow(
      //   color: color,
      //   blurRadius: spread,
      // ),
      if (isSwollen) light,
      BoxShadow(
        color: color.withBlack(depth * swell.asScalar.toInt()),
        offset: Offset(-lightOffset, -lightOffset),
        spreadRadius: (swell.asScalar - 1),
        blurRadius: blur,
      ).scale(scale),
      if (!isSwollen) light,
    ];
  }

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
    // AlignmentGeometry gradientBegin = Alignment.topLeft,
    // AlignmentGeometry gradientEnd = Alignment.bottomRight,
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
          // begin: gradientBegin,
          // end: gradientEnd,
        ),
        boxShadow: boxShadows(
          color: color,
          depth: depth,
          spread: spread,
          swell: swell,
        ),
      );

  static ShapeDecoration shapeDecoration({
    Color color = lightWhite,
    Curvature curvature = Curvature.flat,
    Swell swell = Swell.emboss,
    int depth = 25,
    double spread = 7.5,
    ShapeBorder shape = const RoundedRectangleBorder(),
    DecorationImage? image,
    // AlignmentGeometry gradientBegin = Alignment.topLeft,
    // AlignmentGeometry gradientEnd = Alignment.bottomRight,
  }) =>
      ShapeDecoration(
        image: image,
        shape: shape,
        gradient: linearGradient(
          color: color,
          curvature: curvature,
          swell: swell,
          depth: depth,
          // begin: gradientBegin,
          // end:  gradientEnd,
        ),
        shadows: boxShadows(
          color: color,
          depth: depth,
          spread: spread,
          swell: swell,
        ),
      );

  // /// [morph.ShapeShadow]s support [Gradient]s as the paint \
  // /// vs a standard [BoxShadow]'s tolerance of only `Color`s.
  // ///
  // /// ![side-by-side comparison: isGradient & matching Swell; then isGradient: false & reversed Swells](https://i.imgur.com/PiFRZ6x.png 'side-by-side comparison: isGradient & matching Swell; then isGradient: false & reversed Swells')
  // ///
  // /// ### Inset Shadows
  // /// If this method is used to generate `ShapeShadow`s for inset shadows,
  // /// such as `Appearance.insetShadows`, bear in mind the offset perspective
  // /// for the color shading ordering will be flipped--unless using a gradient
  // /// by `isGradient` set `true` (default).
  // ///
  // /// This gradient-based `List<ShapeShadow>` used as inset shadows would
  // /// resemble an equivalent set of shadows used as standard background
  // /// `ShapeShadow`s.
  // ///
  // /// A non-gradient return from this method (`isGradient` set `false`)
  // /// designed as inset shadows would need its [Swell] `swell` reversed to
  // /// opposite the expected behavior when used as background shadows to mimic
  // /// those background shadows.
  // ///
  // /// ![isGradient == false, requires Swell reversal to achieve same effect with background and inset ShapeShadows](https://i.imgur.com/n2M9JNf.png 'isGradient == false, requires Swell reversal to achieve same effect with background and inset ShapeShadows')
  // ///
  // /// ```dart
  // /// final appearance = Appearance(
  // ///   // 🅰 The shadows from `Appearance` come not from this `decoration`
  // ///   // (though it does provide a `List<BoxShadow>`) ...
  // ///   decoration: Neu.boxDecoration(
  // ///     color: Colors.red[900]!,
  // ///     depth: 25,
  // ///     // 🅰 (and so we may skip this spread parameter in this case)
  // ///     // spread: 15,
  // ///     swell: Swell.emboss,
  // ///   ),
  // ///   // 🅰 ...but from this separate field instead. As a major plus, these
  // ///   // `ShapeShadow`s can be painted as a gradient instead of just a color!
  // ///   shadows: Neu.shapeShadows(
  // ///     isGradient: false, // default is true
  // ///     color: Colors.red[900]!,
  // ///     depth: 20,
  // ///     spread: 12,
  // ///     swell: Swell.emboss, // 🅱 Embossed shadows ...
  // ///   ),
  // ///   insetShadows: Neu.shapeShadows(
  // ///     // 🅱 but because these ShapeShadows are not Gradients:
  // ///     isGradient: false,
  // ///     color: Colors.red[900]!,
  // ///     depth: 20,
  // ///     spread: 12,
  // ///     // 🅱 ... the inset shadows need a Swell reversal to achieve the
  // ///     // same visual effect as the background shadows.
  // ///     swell: Swell.deboss,
  // ///   ),
  // /// );
  // /// ```
  // ///
  // /// ![isGradient == true, same Swell achieves same effect for background or inset ShapeShadows](https://i.imgur.com/gyXvxju.png 'isGradient == true, same Swell achieves same effect for background or inset ShapeShadows')
  // ///
  // /// ```dart
  // /// final appearance = Appearance(
  // ///   decoration: Neu.boxDecoration(
  // ///     color: Colors.red[900]!,
  // ///     depth: 25,
  // ///   ),
  // ///   shadows: Neu.shapeShadows(
  // ///     color: Colors.red[900]!,
  // ///     depth: 30,
  // ///     spread: 12,
  // ///   ),
  // ///   insetShadows: Neu.shapeShadows(
  // ///     color: Colors.red[900]!,
  // ///     depth: 35,
  // ///     spread: 8,
  // ///     // `swell` can be the same for inset shadows when using a gradient
  // ///     // to achieve the same effect on the inside and out.
  // ///   ),
  // /// );
  // /// ```
  // static List<morph.ShapeShadow> shapeShadows({
  //   Color color = lightWhite,
  //   Swell swell = Swell.emboss,
  //   int depth = 25,
  //   double spread = 7.5,
  //   double scale = 1.0,
  //   double offsetScalar = 1.0,
  //   // FOR GRADIENT:
  //   bool isGradient = true,
  //   Curvature curvature = Curvature.flat,
  //   AlignmentGeometry gradientBegin = Alignment.topLeft,
  //   AlignmentGeometry gradientEnd = Alignment.bottomRight,
  // }) {
  //   final blur = spread / swell.asScalar;
  //   final offset = spread * swell.asScalar * offsetScalar;

  //   final isSwollen = swell.asBool;
  //   final gradient = linearGradient(
  //     color: color,
  //     curvature: swell.toCurvature(curvature),
  //     depth: depth,
  //     swell: swell,
  //     begin: gradientBegin,
  //     end: gradientEnd,
  //   );
  //   final light = color.withWhite(depth);
  //   final lights = [light, light];
  //   final dark = color.withBlack(depth);
  //   final darks = [dark, dark];
  //   final shadows = List.generate(
  //         isGradient ? 3 : 1,
  //         (index) => morph.ShapeShadow(
  //           gradient: isGradient
  //               ? gradient
  //               // Create a flat gradient with two of the same color
  //               : LinearGradient(colors: (isSwollen) ? lights : darks),
  //           offset: index == 0
  //               ? Offset(-offset, -offset)
  //               : Offset(-offset / index * 2, -offset / index * 2),
  //           spreadRadius: (swell.asScalar - 1) - (isGradient ? spread : 0),
  //           blurRadius: isGradient ? blur * 2 : blur,
  //         ).scale(scale),
  //       ) +
  //       List.generate(
  //         isGradient ? 3 : 1,
  //         (index) => morph.ShapeShadow(
  //           gradient: isGradient
  //               ? gradient
  //               // Create a flat gradient with two of the same color
  //               : LinearGradient(colors: (isSwollen) ? darks : lights),
  //           offset: index == 0
  //               ? Offset(offset, offset)
  //               : Offset(offset / index * 2, offset / index * 2),
  //           spreadRadius: (swell.asScalar - 1) - (isGradient ? spread : 0),
  //           blurRadius: isGradient ? blur * 2 : blur,
  //         ).scale(scale),
  //       );
  //   return !isSwollen
  //       ? shadows.reversed.toList() // order shadow stack
  //       : shadows;
  // }
}
