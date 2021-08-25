/// Provides [NeuContainer], a specialized [StatelessWidget] that builds two
/// layered [AnimatedContainer]s, one as a solid color backdrop with edge insets
/// and the second conforming to the [Neu]-standard properties to give the inner
/// container a neumorphic or "clay"-like appearance rising out of the lower
/// container.
library neu;

import '../common.dart';
import '../neu.dart';
import 'toggle.dart';

/// Construct a [new NeuContainer], a specialized [StatelessWidget] that builds
/// two layered [AnimatedContainer]s, one as a solid color backdrop with edge
/// [insets] and the second conforming to the [Neu]-standard properties, such as
/// [depth] and [curvature], to give the inner container a neumorphic or
/// "clay"-like appearance rising out of the lower container.
class NeuContainer extends StatelessWidget {
  /// A specialized [StatelessWidget] that builds two layered
  /// [AnimatedContainer]s, one as a solid color backdrop with edge [insets]
  /// and the second conforming to the [Neu]-standard properties, such as
  /// [depth] and [curvature], to give the inner container a neumorphic or
  /// "clay"-like appearance rising out of the lower container.
  ///
  /// ---
  /// #### SEE ALSO:
  ///
  /// * [Neu], the base class defining this design system.
  /// * [AnimatedContainer], which this `Widget` will render and from which
  ///   many if its parameters are copied.
  /// * [NeuToggle] for a widget like this container but that handles its own
  ///   [GestureDetector] for the purpose of "toggling" between two
  ///   *[Neu]morphic* states.
  const NeuContainer({
    Key? key,
    this.color = lightWhite,
    this.depth = defaultDepth,
    this.insets = EdgeInsets.zero,
    this.curvature = Curvature.convex,
    this.swell = Swell.emboss,
    this.spread = defaultSpread,
    this.lightSource = defaultLightSource,

    /// Container
    this.alignment,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.constraints,
    this.shape = defaultShape,
    this.foregroundDecoration,
    this.transform,
    this.transformAlignment,
    this.duration = defaultDuration,
    this.curve = Curves.elasticOut,
    this.onEnd,
    this.child,
  }) : super(key: key);

  /// With all [Neu] design the basis of these decorations is a [color] and a
  /// [depth]. Color should ideally match with or be similar to the color of the
  /// background behind the resulting decoration. The `depth` is the extent to
  /// which this decoration will appear "extruded" from its surface. A larger
  /// `depth` increases the contrast of the shading of colors on either side of
  /// the decoration.
  ///
  /// Default is [lightWhite], `Color(0xFFE0E0E0)`.
  ///
  /// If [insets] is given a non-zero value, this [color] will also be used as
  /// the background for a secondary container under the neumorphic one,
  /// providing a padded, solid-color backdrop for the container.
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

  /// A convenience to provide a padded, solid-color backdrop on which the true
  /// container will be rendered. In a scenario where a background is not a
  /// solid color that matches [color], then [insets] may be initialized
  /// non-negligibly (such as `EdgeInsets.all(25)`) to provide a small platform
  /// for the *[Neu]morphic* effect to be more visible.
  final EdgeInsetsGeometry insets;

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

  /// In terms of [Shadow]s, [spread] is responsible for determining how wide
  /// an area the effect covers and how blurry the shadows appear.
  ///
  /// The default is [defaultSpread], `7.5`.
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
  /// This value is also used as this container's [LinearGradient.begin]
  /// property.
  final Alignment lightSource;

  /// A [ShapeBorder] object provides a description of a shape for a decoration.
  /// It can include information such as how round corners are to be or what the
  /// border edges should look like.
  ///
  /// Default is [defaultShape], a [RoundedRectangleBorder] with a
  /// [defaultRadius] `borderRadius` of `5.0` and no border.
  final ShapeBorder shape;

  // --- Container --- //

  /// Limit the [width] or [height] of this [NeuContainer], excluding any
  /// [margin], in logical pixels.
  ///
  /// Any defined [insets] and [padding] will fit within this range. Outside of
  /// the dimensions defined by these optional fields lies any [EdgeInsets]
  /// from [margin].
  final double? width, height;

  /// Empty space to surround the [NeuContainer] and any [insets].
  ///
  /// If this [NeuContainer] is constrained or has a supplied [width]/[height],
  /// that dimensional description fits within these [EdgeInsets].
  ///
  /// That is to say that the net size of this `Widget` will be any constrained
  /// size (or provided by [child], if non-`null`) *plus* the insets provided
  /// here.
  final EdgeInsetsGeometry? margin;

  /// Empty space to inscribe inside the [Container]. The [child], if any, is
  /// placed inside these [EdgeInsets].
  final EdgeInsetsGeometry? padding;

  /// Additional constraints to apply to the child.
  ///
  /// The [width] and [height] fields are combined with these [constraints].
  ///
  /// The [insets] then [padding] then [child] go inside these constraints.
  final BoxConstraints? constraints;

  /// Align the [child] within the container.
  ///
  /// If non-`null`, the container will expand to fill its parent and position
  /// its child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is `null`.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] but for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry? alignment;

  /// The [Decoration] to paint in *front* of the [child].
  final Decoration? foregroundDecoration;

  /// The transformation matrix to apply before painting the container.
  ///
  /// See [Matrix4].
  final Matrix4? transform;

  /// The alignment of the origin, relative to the size of the container, if
  /// [transform] is specified.
  ///
  /// When [transform] is null, the value of this property is ignored.
  ///
  /// See also:
  ///
  ///  * [Transform.alignment], which is set by this property.
  final AlignmentGeometry? transformAlignment;

  /// How long any changes to the visual properties of this [NeuContainer] will
  /// take to fully propagate and animate. Changes are alterations to the
  /// properties/fields of this [NeuContainer], such as [padding] or [color].
  ///
  /// Default is [defaultDuration] (`1200ms`) which, when paired with a springy
  /// [curve] such as the default [Curves.elasticOut], results in a delicious
  /// bouncing neumorphic transition.
  final Duration duration;

  /// The [Curve] by which to implicitly animate any changes to the properties
  /// of this [NeuContainer]. Specifically, altering one of the fields, such as
  /// modifying [padding] or [color], will animate changes over this animation
  /// curve.
  ///
  /// Default is [Curves.elasticOut] which, when paired with a longer [duration]
  /// such as the default [defaultDuration] (`1200ms`), results in a delicious
  /// bouncing neumorphic transition.
  final Curve curve;

  /// An optional function to perform any time the properties of this
  /// [NeuContainer] are altered.
  final VoidCallback? onEnd;

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        width: width,
        height: height,
        constraints: constraints,
        margin: margin,
        padding: insets,
        decoration: ShapeDecoration(
          shape: shape,
          color: insets == EdgeInsets.zero ? Colors.transparent : color,
        ),
        duration: duration,
        curve: curve,
        child: AnimatedContainer(
          decoration: Neu(
            color: color,
            curvature: curvature,
            swell: swell,
            depth: depth,
            spread: spread,
            lightSource: lightSource,
            shape: shape,
          ).buildShapeDecoration,
          alignment: alignment,
          padding: padding,
          foregroundDecoration: foregroundDecoration,
          transform: transform,
          transformAlignment: transformAlignment,
          duration: duration,
          curve: curve,
          onEnd: onEnd, // Should call in parent?
          child: child,
        ),
      );

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
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('insets', insets,
          defaultValue: null))
      ..add(DiagnosticsProperty<ShapeBorder>('shape', shape))
      ..add(DoubleProperty('width', width, defaultValue: null))
      ..add(DoubleProperty('height', height, defaultValue: null))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin,
          defaultValue: null))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding,
          defaultValue: null))
      ..add(DiagnosticsProperty<BoxConstraints>('constraints', constraints,
          defaultValue: null))
      ..add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment,
          showName: false, defaultValue: null))
      ..add(DiagnosticsProperty<Decoration>(
          'foregroundDeco', foregroundDecoration,
          defaultValue: null))
      ..add(ObjectFlagProperty<Matrix4>.has('transform', transform))
      ..add(DiagnosticsProperty<AlignmentGeometry>(
          'transformAlignment', transformAlignment,
          defaultValue: null));
  }
}
