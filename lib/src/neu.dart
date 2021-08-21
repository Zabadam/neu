/// Neumorphic implementation by [new Neu] object manipulation such as
/// [Neu.buildBoxDecoration], as an example, or by direct static methods
/// such as [Neu.boxDecoration].
library neu;

import 'common.dart';
import 'widgets/container.dart';
import 'widgets/toggle.dart';

/// A ***[Neu]morphic***, or *new [skeuomorphic](https://en.wikipedia.org/wiki/Skeuomorph)*,
/// helper class with a variety of static and instance methods for the
/// generation of shaded decorations conforming to the *neumorphic* design
/// concept.
///
/// These designs are often solid in terms of color variety: genreally a
/// dominant color is used as a backdrop as well as the color of controls and
/// elements. These items that typically appear "on" or "above the surface"
/// in standard design systems are intended in *skeumorphism* to extrude from
/// or rise out of/into the surface.
///
/// This extrusion, which can be imagined as "clay"- or "rubber"-like, is
/// achieved by a combination of same-color elements and background, contrasting
/// shadows, slight variances in color shading and, potentially, gradients.
///
/// {@template neu.properties}
/// ---
/// ---
/// ##### NEUMORPHIC DEFINITION
///
/// ## Principal
///
/// With all [Neu] design the basis of these decorations is a [color] and a
/// [depth]. Color should ideally match or be similar to the color of the
/// background behind the resulting decoration. The `depth` is the extent to
/// which this decoration will appear "extruded" from its surface. A larger
/// `depth` increases the contrast of the shading of colors on either side of
/// the decoration.
///
/// ## Appearance of Shape
///
/// Other customizations include [curvature] and [swell], as well as an
/// overriding [lightSource] represented as an [Alignment].
///
/// A [Curvature] is a description of the appearance of the actual surface of
/// the decoration. A [Curvature.flat] decoration has no gradient (solid-color
/// [Gradient]), while [Curvature.convex] orders a light -> dark gradient in a
/// way that inspires a "bubble"-like appearance.
///
/// *(Other options make the effect more extreme, such as
/// [Curvature.superconvex] or reverse the effect: [Curvature.concave].)*
///
/// A [Swell] is an overall depiction of how the decoration appears in terms
/// of being inset into the surface or extruded from it.
/// - Combining [Swell.emboss] with [Curvature.convex], the decoration will
/// appear like a bubble lifting out of the background.
/// - Combining [Swell.deboss] with [Curvature.concave], the decoration will
/// appear like a bubble popped and depressed into the background.
///
/// ## Override Source of "Light"
///
/// The [lightSource] is always set by default as [defaultLightSource], which
/// is [Alignment.topLeft]. This gives the illusion of lighting the entire
/// neumorphic decoration from the top-left corner. All descriptions of
/// gradient and shadow directionality and the illusion of being *toggled*
/// or *not toggled* are based on this default light source. An overriding
/// [Alignment] may be provided, however, to dynamically "relight" the
/// decorations.
/// - Consider this *lighting* entirely artificial. Aspects of real light
///   physics are not recreated. Simply put, this value is used to
///   offset/shift the light and dark shadows.
///
/// ## Softness of Shadows
///
/// In terms of [Shadow]s, the argument [spread] is responsible for
/// determining how wide an area the effect covers and how blurry the
/// shadows appear.
///
/// Not all methods consider [spread], notably [linearGradient]
/// (and [buildLinearGradient] by extension) create a decoration
/// (a [LinearGradient]) that does not have shadows. These gradients may be
/// combined with shadows in other situations, where [spread] will then be
/// considered.
///
/// {@endtemplate}
/// ---
/// ---
/// ##### NEU USAGE
///
/// ## Using `Neu` Static Methods
///
/// Static methods that expect to be provided parameters
/// (or allowed to default):
/// - [linearGradient]
/// - [textStyle]
/// - [boxShadows]
/// - [boxDecoration]
/// - [shapeDecoration]
///
/// For example:
///
/// ```dart
/// final LinearGradient neuGradient = Neu.linearGradient(
///   color: Colors.red,
///   depth: 25,
///   curvature: Curvature.superconvex,
///   swell: Swell.superemboss,
/// );
/// final List<BoxShadow> neuShadows = Neu.boxShadows(
///   color: Colors.red,
///   depth: 25,
///   curvature: Curvature.superconvex,
///   swell: Swell.superemboss,
/// );
/// final BoxDecoration neuDecoration = BoxDecoration(
///   gradient: neuGradient,
///   boxShadow: neuShadows,
/// );
/// /// Better yet, look into [Neu.boxDecoration].
/// ```
///
/// ## Using a `Neu` Object
///
/// On the other hand, this class may be used to construct [new Neu] or
/// [new Neu.toggle] objects. These objects will utilize their constructor
/// arguments to fill the above static method parameters for easy storage and
/// access or rapid redeployment.
///
/// Getter methods on [new Neu] instantiated objects that consider initialized
/// properties:
/// - [buildLinearGradient]
/// - [buildTextStyle]
/// - [buildBoxShadows]
/// - [buildBoxDecoration]
/// - [buildShapeDecoration]
///
/// ---
/// ---
/// #### SEE ALSO:
///
/// * [NeuTextSpec], a container object for a few [TextStyle]-oriented
///   properties that a `Neu` object employs when calling [buildTextStyle].
///   These are individual parameters when calling [textStyle].
/// * [NeuContainer], a specialized widget that stacks two [AnimatedContainer]s
///   rigged to easily handle *[Neu]morphic* design decorations, including the
///   built-in consideration of [NeuContainer.insets] which creates its own
///   solid-color backdrop for the container in lieu of an existing background.
/// * [NeuToggle], a further specialized [NeuContainer] that considers flag
///   states to drive animations between various [Curvature]s and [Swell]s by
///   rendering with [Neu.toggle] while also handling its own [GestureDetector].
class Neu with Diagnosticable {
  /// A ***neumorphic***, or *new [skeuomorphic](https://en.wikipedia.org/wiki/Skeuomorph)*,
  /// helper class with a variety of methods for the generation of shaded
  /// decorations conforming to the *neumorphic* design concept.
  ///
  /// These designs are often solid in terms of color variety: genreally a
  /// dominant color is used as a backdrop as well as the color of controls and
  /// elements. These items that typically appear "on" or "above the surface"
  /// in standard design systems are intended in *skeumorphism* to extrude from
  /// or rise out of/into the surface.
  ///
  /// This extrusion, which can be imagined as "clay" or "rubber" like, is
  /// achieved by a combination of contrasting shadows, slight variances in
  /// color shading and, potentially, gradients.
  ///
  /// ---
  ///
  /// This class may be used to construct [new Neu] or [new Neu.toggle] objects.
  /// These objects will utilize their constructor arguments to fill static
  /// method arguments as easy storage and access or rapid redeployment.
  ///
  /// Getter methods on [new Neu] instantiated objects:
  /// - [buildLinearGradient]
  /// - [buildTextStyle]
  /// - [buildBoxShadows]
  /// - [buildBoxDecoration]
  /// - [buildShapeDecoration]
  ///
  /// ## Using a `Neu` Object
  ///
  /// ```dart
  /// // final neuObject = Neu.toggle(
  /// final neuObject = Neu(
  ///   color: Colors.red,
  ///   depth: 25,
  ///   spread: 10,
  ///
  ///   /// These parameters (curvature and swell) for `Neu.toggle` are handled
  ///   /// dynamically by the below flags.
  ///   curvature: Curvature.flat,
  ///   swell: Swell.emboss,
  ///
  ///   /// These flags are only valid for `Neu.toggle` where they drive the
  ///   /// curvature and swell based on true or false states.
  ///   // isPressed: isPressed,
  ///   // isFlat: true,
  ///   // isSuper: true,
  ///
  ///   lightSource: Alignment.topLeft,
  ///   shape: RoundedRectangleBorder(
  ///     borderRadius: BorderRadius.circular(3.0),
  ///     // side: BorderSide(width: 0.5, color: color.withWhite(10)),
  ///     // side: BorderSide(width: 0.5, color: color),
  ///   ),
  /// );
  /// ```
  ///
  /// This `Neu` object may then, for example, be used to generate a
  /// [ShapeDecoration] like so:
  /// ```dart
  /// final neuContainer = Container(
  ///   decoration: neuObject.buildShapeDecoration,
  /// );
  /// ```
  ///
  /// ---
  /// #### SEE ALSO:
  ///
  /// * [NeuTextSpec], a container object for a few [TextStyle]-oriented
  ///   properties that a `Neu` object employs when calling [buildTextStyle].
  ///   These are individual parameters when calling [textStyle].
  /// * [new Neu.toggle] a named constructor which dynamically controls
  ///   [Curvature] and [Swell] by "flags" or [bool]s that describe state
  ///   (i.e. either *toggled* or *not toggled*).
  /// * [NeuContainer], a specialized widget that stacks two
  ///   [AnimatedContainer]s rigged to easily handle *[Neu]morphic* design
  ///   decorations, including the built-in consideration of
  ///   [NeuContainer.insets] which creates its own solid-color backdrop for the
  ///   container in lieu of an existing background.
  /// * [Neu] static methods that expect to be provided parameters
  ///   (or allowed to default) with no object instantiation:
  ///   - [linearGradient]
  ///   - [textStyle]
  ///   - [boxShadows]
  ///   - [boxDecoration]
  ///   - [shapeDecoration]
  ///
  /// {@macro neu.properties}
  const Neu({
    this.color = lightWhite,
    this.depth = defaultDepth,
    this.curvature = Curvature.convex,
    this.swell = Swell.emboss,
    this.spread = defaultSpread,
    this.lightSource = defaultLightSource,
    this.neuTextSpec = const NeuTextSpec(),
    this.borderRadius = BorderRadius.zero,
    this.shape = defaultShape,
  })  :
        // See [Neu.toggle] named constructor
        _isToggled = null,
        _isFlat = null,
        _isSuper = null,
        _depthMultiplier = null,
        _spreadMultiplier = null;

  /// Construct a [Neu.toggle] to deploy neumorphic decorations that have two
  /// states: either *not toggled* or *toggled*. Consider a raised,
  /// [Swell.emboss]ed button as the output from the first state; then a
  /// depressed, darker [Swell.deboss]ed button is the second state; controlled
  /// via flag [isToggled].
  ///
  /// Further refine the appearance of the decorations with either
  /// mutually-exclusive flag [isFlat], which enforces the usage of
  /// [Curvature.flat] regardless of [isToggled] state; or [isSuper], which opts
  /// into using [Curvature]s and [Swell]s that fit the [Degree.SUPER]
  /// description, increasing intensity and contrast.
  ///
  /// When in a state of [isToggled] == `true`, the arguments to
  /// [depthMultiplier] and [spreadMultiplier] are applied to [depth] and
  /// [spread] automatically. To remove this effect, pass a value of `1.0` for
  /// these multipliers.
  ///
  /// ---
  /// #### SEE ALSO:
  ///
  /// * [NeuTextSpec], a container object for a few [TextStyle]-oriented
  ///   properties that a `Neu` object employs when calling [buildTextStyle].
  ///   These are individual parameters when calling [textStyle].
  /// * [new Neu] the default constructor which allows manual control of
  ///   [Curvature] and [Swell].
  /// * [NeuToggle], a specialized [NeuContainer] that animates its rendered
  ///   [Neu.toggle] decorations while also handling its own [GestureDetector].
  /// * [Neu] static methods that expect to be provided parameters
  ///   (or allowed to default) with no object instantiation:
  ///   - [linearGradient]
  ///   - [textStyle]
  ///   - [boxShadows]
  ///   - [boxDecoration]
  ///   - [shapeDecoration]
  ///
  /// {@macro neu.properties}
  const Neu.toggle({
    this.color = lightWhite,
    this.depth = defaultDepth,
    this.spread = defaultSpread,
    this.lightSource = defaultLightSource,
    bool isToggled = false,
    bool isFlat = false,
    bool isSuper = false,
    double depthMultiplier = defaultDepthMultiplier,
    double spreadMultiplier = defaultSpreadMultiplier,
    this.neuTextSpec = const NeuTextSpec(),
    this.borderRadius = BorderRadius.zero,
    this.shape = defaultShape,
  })  : _isToggled = isToggled,
        _isFlat = isFlat,
        _isSuper = isSuper,
        _depthMultiplier = depthMultiplier,
        _spreadMultiplier = spreadMultiplier,
        curvature = isFlat
            ? Curvature.flat
            : isToggled
                ? isSuper
                    ? Curvature.superconcave
                    : Curvature.concave
                : isSuper
                    ? Curvature.superconvex
                    : Curvature.convex,
        swell = isToggled
            ? isSuper
                ? Swell.superdeboss
                : Swell.deboss
            : isSuper
                ? Swell.superemboss
                : Swell.emboss;

  /// With all [Neu] design the basis of these decorations is a [color] and a
  /// [depth]. Color should ideally match with or be similar to the color of the
  /// background behind the resulting decoration. The `depth` is the extent to
  /// which this decoration will appear "extruded" from its surface. A larger
  /// `depth` increases the contrast of the shading of colors on either side of
  /// the decoration.
  ///
  /// Default is [lightWhite], `Color(0xFFE0E0E0)`.
  final Color color;

  /// With all [Neu] methods the basis of these decorations is a [color] and a
  /// [depth]. Color should ideally match or be similar to the color of the
  /// background behind the resulting decoration. The `depth` is the extent to
  /// which this decoration will appear "extruded" from its surface. A larger
  /// `depth` increases the contrast of the shading of colors on either side of
  /// the decoration.
  ///
  /// Default is [defaultDepth], `25`.
  final int depth;

  /// A [Curvature] is a description of the appearance of the actual surface of
  /// the decoration. A [Curvature.flat] decoration has no gradient (solid-color
  /// [Gradient]), while [Curvature.convex] orders a light -> dark gradient in a
  /// way that inspires a "bubble"-like appearance, especially when combined
  /// with a [swell] of [Swell.emboss].
  /// - Conversely, to pop that bubble like its bubble-wrap, [Swell.deboss]
  ///   can be combined with [Curvature.concave].
  ///
  /// *(Other options make the effect more extreme, namely
  /// [Curvature.superconvex] and [Curvature.superconcave].)*
  ///
  /// Each constant in the [Curvature] enum has a description of how it affects
  /// various areas in its usage.
  ///
  /// The default is [Curvature.flat], the result from which will be a
  /// solid-color (non-shaded) gradient.
  final Curvature curvature;

  /// A [Swell] is an overall depiction of how the decoration appears in terms
  /// of being inset into the surface or extruded from it.
  ///
  /// Each constant in the [Swell] enum has a description of how it affects
  /// various areas in its usage.
  ///
  /// The default is [Swell.emboss] which make a visual foundation for an
  /// element to be clickable or *not toggle* in a toggleable scenario.
  /// Combines great with [Curvature.flat] or [Curvature.convex] for a
  /// bubble-like appearance.
  ///
  /// The opposite would be [Swell.deboss]. This state gives a good impression
  /// (😏) that an element has been clicked or *toggled on* in a toggleable
  /// scenario. Combines great with [Curvature.concave] for an inset, popped
  /// bubble-wrap appearance.
  ///
  /// The effect is made more dramatic by [Swell.superemboss] or
  /// [Swell.superdeboss].
  final Swell swell;

  /// In terms of *[Neu]morphic* [Shadow]s, the argument [spread] is responsible
  /// for determining how wide an area the effect covers and how blurry the
  /// shadows appear.
  ///
  /// The default is [defaultSpread], `7.5`.
  ///
  /// The method [buildLinearGradient] ignores this property as it corresponds
  /// to [Shadow]s, a visual element missing from a [LinearGradient]. These
  /// gradients may be combined with shadows in other situations, where [spread]
  /// will then be considered.
  final double spread;

  /// The [lightSource] is always set by default as [defaultLightSource], which
  /// is [Alignment.topLeft]. This gives the illusion of lighting the entire
  /// neumorphic decoration from the top-left corner. All descriptions of
  /// gradient and shadow directionality and the illusion of being *toggled*
  /// or *not toggled* are based on this default light source. An overriding
  /// [Alignment] may be provided, however, to dynamically "relight" the
  /// decorations.
  /// - Consider this *lighting* entirely artificial. Aspects of real light
  ///   physics are not recreated. Simply put, this value is used to
  ///   offset/shift the light and dark shadows.
  ///
  /// The method [buildLinearGradient] uses this property as its
  /// [LinearGradient.begin] property.
  final Alignment lightSource;

  /// Container object utilized only by [buildTextStyle] for `baseStyle` from
  /// which to copy [TextStyle] as well as [Rect] and [TextDirection] fields
  /// for painting a gradient atop the text instead of just a solid color.
  ///
  /// Cleans up fields of a [new Neu] object as these three properties
  /// contribute to only a single method choice, [buildTextStyle].
  final NeuTextSpec neuTextSpec;

  /// Employed only by [buildBoxDecoration]. Default is [BorderRadius.zero].
  ///
  /// Provide a value such as `BorderRadius.all(Radius.circular(15.0))` for
  /// rounded corners.
  final BorderRadius borderRadius;

  /// A [ShapeBorder] object provides a description of a shape for a decoration.
  /// It can include information such as how round corners are to be or what the
  /// border edges should look like.
  ///
  /// Employed only by [buildShapeDecoration]. Default is [defaultShape], a
  /// [RoundedRectangleBorder] with a [defaultRadius] `borderRadius` of `5.0`
  /// and no border.
  final ShapeBorder shape;

  /// If this [Neu] object is created by [new Neu.toggle] constructor, this
  /// property is initialized by the `isToggled` argument in the constructor.
  ///
  /// This flag, combined by considering either constructor argument `isFlat`
  /// or `isSuper`, drives the selection of [curvature] and [swell] dynamically.
  ///
  /// If not constructing a [Neu.toggle], initialized to `null`.
  final bool? _isToggled;

  /// If this [Neu] object is created by [new Neu.toggle] constructor, this
  /// property is initialized by the `isFlat` or `isSuper` argument in the
  /// constructor.
  final bool? _isFlat, _isSuper;

  /// If this [Neu] object is created by [new Neu.toggle] constructor, this
  /// property is initialized by the `depthMultiplier` or `spreadMultiplier`
  /// argument in the constructor.
  ///
  /// When in a state of `(Neu.toggle).isToggled == true`, the arguments to
  /// `depthMultiplier` and `spreadMultiplier` are applied to [depth] and
  /// [spread] automatically. To remove this effect, pass a value of `1.0` for
  /// these multipliers.
  ///
  /// Default [_depthMultiplier] is `1.3`, increasing contrast when toggled on,
  /// and default [_spreadMultiplier] is `0.4`, making the box shadows smaller
  /// and tighter. If not constructing a [Neu.toggle], initialized to `null`.
  final double? _depthMultiplier, _spreadMultiplier;

  // --- Instantiated `Neu` object getter properties considering fields above --- //

  /// Does not consider [spread] nor [shape], [borderRadius].
  /// Ignores [neuTextSpec].
  ///
  /// {@macro neu.properties}
  Gradient get buildLinearGradient => Neu.linearGradient(
        color: color,
        depth: depth,
        curvature: curvature,
        swell: swell,
        begin: lightSource,
      );

  /// Does not consider [shape], [borderRadius].
  ///
  /// {@macro neu.properties}
  TextStyle get buildTextStyle => Neu.textStyle(
        color: color,
        depth: _isToggled == true ? (depth * _depthMultiplier!).round() : depth,
        curvature: curvature,
        swell: swell,
        spread: _isToggled == true ? spread * _spreadMultiplier! : spread,
        lightSource: lightSource,
        baseStyle: neuTextSpec.baseStyle,
        gradientRect: neuTextSpec.rect,
        textDirection: neuTextSpec.textDirection,
      );

  /// Does not consider [shape], [borderRadius]. Ignores [neuTextSpec].
  ///
  /// {@macro neu.properties}
  List<BoxShadow> get buildBoxShadows => Neu.boxShadows(
        color: color,
        depth: _isToggled == true ? (depth * _depthMultiplier!).round() : depth,
        curvature: curvature,
        swell: swell,
        spread: _isToggled == true ? spread * _spreadMultiplier! : spread,
        lightSource: lightSource,
      );

  /// Does not consider [shape]. Ignores [neuTextSpec].
  ///
  /// {@macro neu.properties}
  BoxDecoration get buildBoxDecoration => Neu.boxDecoration(
        color: color,
        depth: _isToggled == true ? (depth * _depthMultiplier!).round() : depth,
        curvature: curvature,
        swell: swell,
        spread: _isToggled == true ? spread * _spreadMultiplier! : spread,
        lightSource: lightSource,
        borderRadius: borderRadius,
      );

  /// Does not consider [borderRadius]. Ignores [neuTextSpec].
  ///
  /// {@macro neu.properties}
  ShapeDecoration get buildShapeDecoration => Neu.shapeDecoration(
        color: color,
        depth: _isToggled == true ? (depth * _depthMultiplier!).round() : depth,
        curvature: curvature,
        swell: swell,
        spread: _isToggled == true ? spread * _spreadMultiplier! : spread,
        lightSource: lightSource,
        shape: shape,
      );

  // --- Static `Neu` methods considering provided parameters --- //

  /// Build a *[Neu]morphic* [LinearGradient], the [Gradient.colors] for which
  /// are determined by evaluating [color], [depth], and the rest of the
  /// [Neu]-standard parameters.
  ///
  /// This static method used entirely on its own is not that useful. Instead,
  /// this method is mostly employed by other methods to generate their required
  /// gradient property.
  ///
  /// {@macro neu.properties}
  static Gradient linearGradient({
    required Color color,
    required int depth,
    Curvature curvature = Curvature.convex,
    Swell swell = Swell.emboss,
    Alignment begin = defaultLightSource,
    TileMode tileMode = TileMode.clamp,
    GradientTransform? transform,
  }) =>
      LinearGradient(
        colors: curvature.colorList(color, swell: swell, depth: depth),
        begin: begin,
        end: -begin,
        tileMode: tileMode,
        transform: transform,
      );

  /// Build a *[Neu]morphic* [TextStyle] that begins with [baseStyle].
  ///
  /// The `baseStyle` defaults to an empty `TextStyle` and is offered as a
  /// convenience parameter. This base style will be returned, copied with
  /// neumorphic decorations.
  ///
  /// If a [Rect] is provided as [gradientRect], then a gradient shader is
  /// generated for this `TextStyle` (instead of only a color) to paint atop
  /// the glyphs.
  /// - Also then consider the [textDirection] as it will not be obtained by
  ///   this static method automatically.
  ///
  /// {@macro neu.properties}
  static TextStyle textStyle({
    TextStyle baseStyle = const TextStyle(),
    required Color color,
    required int depth,
    Curvature curvature = Curvature.flat,
    Swell swell = Swell.emboss,
    double spread = 5,
    AlignmentGeometry lightSource = defaultLightSource,
    Rect? gradientRect,
    TextDirection? textDirection,
  }) {
    final direction = textDirection ?? TextDirection.ltr;
    final paint = Paint();
    if (gradientRect != null) {
      paint.shader = linearGradient(
        color: color,
        curvature: curvature,
        swell: swell,
        depth: depth,
        begin: lightSource.resolve(direction),
      ).createShader(gradientRect, textDirection: direction);
    }
    final style = baseStyle.copyWith(
      color: color.withBlack(depth ~/ swell.divisor(depth) - 1),
      shadows: boxShadows(
        color: color,
        curvature: curvature,
        swell: swell,
        depth: depth,
        spread: spread,
        lightSource: lightSource.resolve(direction),
        offsetScalar: 0.6,
      ),
    );
    return (paint.shader == null) ? style : style.copyWith(foreground: paint);
  }

  /// See [BoxShadow.scale] for the usage of double [scale].
  ///
  /// Use [offsetScalar] to make the effect less dramatic and scale the offsets
  /// for use as a [textStyle] for example.
  ///
  /// {@macro neu.properties}
  static List<BoxShadow> boxShadows({
    required Color color,
    required int depth,
    Curvature curvature = Curvature.convex,
    Swell swell = Swell.emboss,
    double spread = defaultSpread,
    Alignment lightSource = defaultLightSource,
    double scale = 1.0,
    double offsetScalar = 1.0,
  }) {
    final isSwollen = swell.isSwollen;
    final clampedSpread = spread.clamp(0, 999).toDouble();
    final scaledSpread = clampedSpread * offsetScalar;
    final lightOffset = isSwollen ? scaledSpread : -scaledSpread;
    final colors = swell.degree == Degree.SUPER
        ? Curvature.superconvex.colorList(color, swell: swell, depth: depth)
        : Curvature.convex.colorList(color, swell: swell, depth: depth);

    final lightShadow = BoxShadow(
      color: colors[0],
      offset: Offset(lightSource.x * lightOffset, lightSource.y * lightOffset),
      // spreadRadius: (swell.scalar - 1), // super inflates by 1.5 - 1 = 0.5
      blurRadius: clampedSpread,
    ).scale(scale);

    /// [Shadow]s stack vertically in the Z-axis in the order in which they are
    /// listed in this iterable. That is, later [Shadow]s are painted on top of
    /// earlier ones without blending.
    return [
      if (!isSwollen) lightShadow,

      /// darkShadow:
      BoxShadow(
        color: colors[2],
        offset: Offset(
            -(lightSource.x * lightOffset), -(lightSource.y * lightOffset)),
        // spreadRadius: (swell.scalar - 1), // super inflates by 1.5 - 1 = 0.5
        blurRadius: clampedSpread,
      ).scale(scale),

      if (isSwollen) lightShadow,
    ];
  }

  /// {@macro neu.properties}
  static BoxDecoration boxDecoration({
    required Color color,
    required int depth,
    Curvature curvature = Curvature.flat,
    Swell swell = Swell.emboss,
    double spread = defaultSpread,
    Alignment lightSource = defaultLightSource,
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    DecorationImage? image,
    BlendMode? blendMode,
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
          swell: swell,
          depth: depth,
          begin: lightSource,
        ),
        boxShadow: boxShadows(
          color: color,
          curvature: curvature,
          swell: swell,
          depth: depth,
          spread: spread,
          lightSource: lightSource,
        ),
      );

  /// {@macro neu.properties}
  static ShapeDecoration shapeDecoration({
    required Color color,
    required int depth,
    Curvature curvature = Curvature.flat,
    Swell swell = Swell.emboss,
    double spread = defaultSpread,
    Alignment lightSource = defaultLightSource,
    ShapeBorder shape = const RoundedRectangleBorder(),
    DecorationImage? image,
  }) =>
      ShapeDecoration(
        shape: shape,
        image: image,
        gradient: linearGradient(
          color: color,
          depth: depth,
          curvature: curvature,
          swell: swell,
          begin: lightSource,
        ),
        shadows: boxShadows(
          color: color,
          depth: depth,
          curvature: curvature,
          swell: swell,
          spread: spread,
          lightSource: lightSource,
        ),
      );

  /// 📋 Create a [new Neu] object that has the same properties as `this` one
  /// except for any optional parameters passed through the [copyWith] method.
  Neu copyWith({
    Color? color,
    int? depth,
    Curvature? curvature,
    Swell? swell,
    double? spread,
    Alignment? lightSource,
    NeuTextSpec? neuTextSpec,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
  }) =>
      Neu(
        color: color ?? this.color,
        depth: depth ?? this.depth,
        curvature: curvature ?? this.curvature,
        swell: swell ?? this.swell,
        spread: spread ?? this.spread,
        lightSource: lightSource ?? this.lightSource,
        neuTextSpec: neuTextSpec ?? this.neuTextSpec,
        borderRadius: borderRadius ?? this.borderRadius,
        shape: shape ?? this.shape,
      );

  /// 📋 Create a [new Neu] object that has the same properties as `this` one
  /// except for any optional parameters passed through the [copyWith] method.
  Neu copyWithToggle({
    Color? color,
    int? depth,
    double? spread,
    Alignment? lightSource,
    bool? isToggled,
    bool? isFlat,
    bool? isSuper,
    double? depthMultiplier,
    double? spreadMultiplier,
    NeuTextSpec? neuTextSpec,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
  }) {
    return Neu.toggle(
      color: color ?? this.color,
      depth: depth ?? this.depth,
      spread: spread ?? this.spread,
      lightSource: lightSource ?? this.lightSource,
      isToggled: isToggled ?? _isToggled ?? false,
      isFlat: isFlat ?? _isFlat ?? false,
      isSuper: isSuper ?? _isSuper ?? false,
      depthMultiplier:
          depthMultiplier ?? _depthMultiplier ?? defaultDepthMultiplier,
      spreadMultiplier:
          spreadMultiplier ?? _spreadMultiplier ?? defaultSpreadMultiplier,
      neuTextSpec: neuTextSpec ?? this.neuTextSpec,
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(IntProperty('depth', depth))
      ..add(DiagnosticsProperty<Curvature>('curvature', curvature))
      ..add(DiagnosticsProperty<Swell>('swell', swell))
      ..add(DoubleProperty('spread', spread))
      ..add(DiagnosticsProperty<Alignment>('lightSource', lightSource))
      ..add(DiagnosticsProperty<NeuTextSpec>('neuTextSpec', neuTextSpec))
      ..add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius))
      ..add(DiagnosticsProperty<ShapeBorder>('shape', shape))
      ..add(FlagProperty(
        'isToggled',
        value: _isToggled,
        defaultValue: null,
        ifFalse: 'toggleable: isPressed = false',
        ifTrue: 'toggleable: isPressed = true',
      ))
      ..add(DoubleProperty(
        'depthMultiplier',
        _depthMultiplier,
        defaultValue: null,
        ifNull: '',
        showName: false,
        tooltip: 'depth multiplier',
      ))
      ..add(DoubleProperty(
        'spreadMultiplier',
        _spreadMultiplier,
        defaultValue: null,
        ifNull: '',
        showName: false,
        tooltip: 'spread multiplier',
      ));
  }
}
