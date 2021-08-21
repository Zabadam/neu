/// Provides [NeuToggle], a [StatefulWidget] that builds a [Neu.toggle] wrapped
/// in a self-handling [GestureDetector].
library neu;

import '../common.dart';
import '../neu.dart';
import 'container.dart';

/// Create a [new NeuToggle], a [StatefulWidget] that builds a [Neu.toggle]
/// wrapped in a self-handling [GestureDetector].
///
/// Similar in design to [NeuContainer] in that the resulting `Widget` is
/// comprised of two stacked [AnimatedContainer]s, the first of which holds the
/// base color and may employ [insets] to provide the inner [Neu]-design
/// container the opportunity to extrude or "rise" from the former.
///
/// The difference is that this [StatefulWidget] not only utilizes a
/// [Neu.toggle] to toggle neumorphic appearance states instead of manual
/// control over [Curvature] and [Swell], but it also wraps the container with
/// a [GestureDetector] that will trigger its own [Neu.toggle.isPressed] toggles
/// onTap/click and fire the [onToggle] callback with a [bool] of the new state.
///
/// See [Neu.toggle] for more information.
///
/// See also: [AnimatedContainer], which this `Widget` will render and from
/// which many if its parameters are copied.
class NeuToggle extends StatefulWidget {
  /// A [StatefulWidget] that builds a [Neu.toggle] wrapped in a self-handling
  /// [GestureDetector].
  ///
  /// Similar in design to [NeuContainer] in that the resulting `Widget` is
  /// comprised of two stacked [AnimatedContainer]s, the first of which holds
  /// the base color and may employ [insets] to provide the inner [Neu]-design
  /// container the opportunity to extrude or "rise" from the former.
  ///
  /// The difference is that this [StatefulWidget] not only utilizes a
  /// [Neu.toggle] to toggle neumorphic appearance states instead of manual
  /// control over [Curvature] and [Swell], but it also wraps the container with
  /// a [GestureDetector] that will trigger its own [Neu.toggle.isPressed]
  /// toggles onTap/click and fire the [onToggle] callback with a [bool] of the
  /// new state.
  /// - If this `Widget` is toggled by a simple tap, this `void Function(bool)`
  ///   will be called once with the new state of `isToggled`.
  /// - If this `Widget` is long-pressed, the function will be called on
  ///   long-press start (with, say, callback `true`) and called again on
  ///   long-press end (then with callback `false` if initially true).
  ///
  /// ---
  /// #### SEE ALSO:
  ///
  /// * [Neu], the base class defining this design system.
  /// * [Neu.toggle] for more information on the concept of "toggling" in
  ///   *[Neu]morphism*.
  /// * [AnimatedContainer], which this `Widget` will render and from which
  ///   many if its parameters are copied.
  const NeuToggle({
    Key? key,
    this.color = lightWhite,
    this.depth = defaultDepth,
    this.insets = EdgeInsets.zero,
    this.spread = defaultSpread,
    this.lightSource = defaultLightSource,
    this.isFlat = false,
    this.isSuper = false,
    this.depthMultiplier = defaultDepthMultiplier,
    this.spreadMultiplier = defaultSpreadMultiplier,
    this.providesFeedback = false,

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
    this.onToggle,
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

  /// Further refine the appearance of the decorations with either
  /// mutually-exclusive flag [isFlat], which enforces the usage of
  /// [Curvature.flat] regardless of `isToggled` state; or [isSuper], which opts
  /// into using [Curvature]s and [Swell]s that fit the [Degree.SUPER]
  /// description, increasing intensity and contrast.
  final bool isFlat, isSuper;

  /// When in a state of `isToggled, [depthMultiplier] and [spreadMultiplier]
  /// are applied to [depth] and [spread] automatically. To remove this effect,
  /// pass a value of `1.0` for these multipliers.
  ///
  /// Default [depthMultiplier] is `1.3`, increasing contrast when toggled on,
  /// and default [spreadMultiplier] is `0.4`, making the box shadows smaller
  /// and tighter.
  final double depthMultiplier, spreadMultiplier;

  /// A convenience flag for calling [HapticFeedback.vibrate] when triggering
  /// [onToggle] as the state of this widget has been toggled (by tap or click).
  ///
  /// Default is `false` such that there is no vibration.
  final bool providesFeedback;

  /// A [ShapeBorder] object provides a description of a shape for a decoration.
  /// It can include information such as how round corners are to be or what the
  /// border edges should look like.
  ///
  /// Default is [defaultShape], a [RoundedRectangleBorder] with a
  /// [defaultRadius] `borderRadius` of `5.0` and no border.
  final ShapeBorder shape;

  // --- Container --- //

  /// Limit the [width] or [height] of this [NeuToggle], excluding any [margin],
  /// in logical pixels.
  ///
  /// Any defined [insets] and [padding] will fit within this range. Outside of
  /// the dimensions defined by these optional fields lies any [EdgeInsets]
  /// from [margin].
  final double? width, height;

  /// Empty space to surround the [NeuToggle] and any [insets].
  ///
  /// If this [NeuToggle] is constrained or has a supplied [width]/[height],
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

  /// The [Decoration] to paint in front of the [child].
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

  /// How long any changes to the visual properties of this [NeuToggle] will
  /// take to fully propagate and animate; changes could be either toggling its
  /// state with a tap/click which will trigger [onToggle] with the current
  /// status (`bool`) or by changing one of the fields, such as [padding].
  ///
  /// Default is [defaultDuration] (`1200ms`) which, when paired with a springy
  /// [curve] such as the default [Curves.elasticOut], results in a delicious
  /// bouncing neumorphic transition.
  final Duration duration;

  /// The [Curve] by which to implicitly animate any changes to the properties
  /// of this [NeuToggle]. Specifically, altering one of the fields in
  /// constructor or toggling the state by tap/click will animate changes over
  /// this animation curve.
  ///
  /// Default is [Curves.elasticOut] which, when paired with a longer [duration]
  /// such as the default [defaultDuration] (`1200ms`), results in a delicious
  /// bouncing neumorphic transition.
  final Curve curve;

  /// An optional function to perform any time the state of this [NeuToggle]
  /// is toggled (tapped/clicked on).
  ///
  /// If this `Widget` is toggled by a simple tap, this `void Function(bool)`
  /// will be called once with the new state of `isToggled`.
  ///
  /// If this `Widget` is long-pressed, the function will be called on
  /// long-press start (with, say, callback `true`) and called again on
  /// long-press end (then with callback `false` if initially true).
  final Function(bool)? onToggle;

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
  _NeuToggleState createState() => _NeuToggleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(IntProperty('depth', depth))
      ..add(DoubleProperty('spread', spread))
      ..add(DiagnosticsProperty<Alignment>('lightSource', lightSource))
      ..add(DiagnosticsProperty<ShapeBorder>('shape', shape))
      ..add(DoubleProperty(
        'depthMultiplier',
        depthMultiplier,
        defaultValue: null,
        ifNull: '',
        showName: false,
        tooltip: 'depth multiplier',
      ))
      ..add(DoubleProperty(
        'spreadMultiplier',
        spreadMultiplier,
        defaultValue: null,
        ifNull: '',
        showName: false,
        tooltip: 'spread multiplier',
      ))
      ..add(DoubleProperty('width', width, defaultValue: null))
      ..add(DoubleProperty('height', height, defaultValue: null))
      ..add(DiagnosticsProperty<BoxConstraints>('constraints', constraints,
          defaultValue: null))
      ..add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment,
          showName: false, defaultValue: null))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('insets', insets,
          defaultValue: null))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin,
          defaultValue: null))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding,
          defaultValue: null))
      ..add(DiagnosticsProperty<Decoration>(
          'foregroundDeco', foregroundDecoration, defaultValue: null))
      ..add(ObjectFlagProperty<Matrix4>.has('transform', transform))
      ..add(DiagnosticsProperty<AlignmentGeometry>(
          'transformAlignment', transformAlignment,
          defaultValue: null));
  }
}

class _NeuToggleState extends State<NeuToggle> {
  bool isToggled = false;

  void toggle() {
    if (widget.providesFeedback) HapticFeedback.vibrate();
    setState(() => isToggled = !isToggled);
    widget.onToggle?.call(isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      onLongPress: toggle,
      onLongPressUp: toggle,
      child: AnimatedContainer(
        color: widget.insets == EdgeInsets.zero
            ? Colors.transparent
            : widget.color,
        width: widget.width,
        height: widget.height,
        constraints: widget.constraints,
        margin: widget.margin,
        padding: widget.insets,
        duration: widget.duration,
        curve: widget.curve,
        child: AnimatedContainer(
          decoration: Neu.toggle(
            isToggled: isToggled,
            isFlat: widget.isFlat,
            isSuper: widget.isSuper,
            color: widget.color,
            depth: widget.depth,
            spread: widget.spread,
            depthMultiplier: widget.depthMultiplier,
            spreadMultiplier: widget.spreadMultiplier,
            lightSource: widget.lightSource,
            shape: widget.shape,
          ).buildShapeDecoration,
          alignment: widget.alignment,
          padding: widget.padding,
          foregroundDecoration: widget.foregroundDecoration,
          transform: widget.transform,
          transformAlignment: widget.transformAlignment,
          duration: widget.duration,
          curve: widget.curve,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(FlagProperty(
      'isToggled',
      value: isToggled,
      defaultValue: null,
      ifFalse: 'isToggled = false',
      ifTrue: 'isToggled = true',
    ));
  }
}
