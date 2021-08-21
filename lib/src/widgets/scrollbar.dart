/// WORK IN PROGRESS
library neu;

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../common.dart';
import '../neu.dart';

const double _kScrollbarThickness = 10.0;
const double _kScrollbarThicknessWithTrack = 14.0;
const double _kScrollbarMargin = 4.0;
const double _kScrollbarMinLength = 48.0;
const Radius _kScrollbarRadius = Radius.circular(10.0);
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

/// See also:
///
/// * [Scrollbar], the vanilla Flutter scrollbar which extends [RawScrollbar].
/// * [RawScrollbar], a basic scrollbar that fades in and out, extended
///   by this class to add more animations and behaviors.
/// * [ScrollbarTheme], which configures the Scrollbar's appearance.
/// * [ListView], which displays a linear, scrollable list of children,
///   suitable for wrapping in a [NeuScrollbar].
/// * [GridView], which displays a two-dimensional, scrollable array of
///   children, suitable for wrapping in a [NeuScrollbar].
class NeuScrollbar extends RawScrollbar {
  /// Creates a neumorphic design scrollbar that by default will connect to the
  /// closest scrollable descendant of [child].
  ///
  /// The [child] should be a source of [ScrollNotification] notifications,
  /// typically a [Scrollable] widget.
  ///
  /// If the [controller] is `null`, the default behavior is to
  /// enable scrollbar dragging using the [PrimaryScrollController].
  ///
  /// When `null`, [thickness] defaults to `10.0px`. A `null` [radius] will
  /// result in a default of an `10.0px` circular radius about the corners of
  /// the scrollbar thumb.
  const NeuScrollbar({
    Key? key,
    Color? color,
    this.depth = defaultDepth,
    this.spread = defaultSpread,
    this.lightSource = defaultLightSource,

    /// Scrollbar
    ScrollController? controller,
    bool? interactive,
    bool? isAlwaysShown,
    this.showTrackOnHover,
    Radius? radius,
    double? thickness,
    this.hoverThickness,
    ScrollNotificationPredicate? notificationPredicate,
    required Widget child,
  }) : super(
          key: key,
          controller: controller,
          interactive: interactive,
          isAlwaysShown: isAlwaysShown,
          thumbColor: color,
          radius: radius,
          thickness: thickness,
          fadeDuration: _kScrollbarFadeDuration,
          timeToFade: _kScrollbarTimeToFade,
          pressDuration: Duration.zero,
          notificationPredicate:
              notificationPredicate ?? defaultScrollNotificationPredicate,
          child: child,
        );

  // /// With all [Neu] design the basis of these decorations is a [color] and a
  // /// [depth]. Color should ideally match with or be similar to the color of the
  // /// background behind the resulting decoration. The `depth` is the extent to
  // /// which this decoration will appear "extruded" from its surface. A larger
  // /// `depth` increases the contrast of the shading of colors on either side of
  // /// the decoration.
  // ///
  // /// Falls back to `Theme.of(context).colorScheme.onSurface`.
  // final Color? color;

  /// With all [Neu] methods the basis of these decorations is a color and a
  /// [depth]. Color should ideally match or be similar to the color of the
  /// background behind the resulting decoration. The `depth` is the extent to
  /// which this decoration will appear "extruded" from its surface. A larger
  /// `depth` increases the contrast of the shading of colors on either side of
  /// the decoration.
  ///
  /// Default is [defaultDepth], `25`.
  final int depth;

  /// In terms of *[Neu]morphic* [Shadow]s, the argument [spread] is responsible
  /// for determining how wide an area the effect covers and how blurry the
  /// shadows appear.
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
  final Alignment lightSource;

  /// Controls if the track will show on hover and remain, including during
  /// drag.
  ///
  /// If this property is `null`, then [ScrollbarThemeData.showTrackOnHover] of
  /// [ThemeData.scrollbarTheme] is used. If that is also `null`, the default
  /// value is `false`.
  final bool? showTrackOnHover;

  /// The thickness of the scrollbar when a hover state is active and
  /// [showTrackOnHover] is `true`.
  ///
  /// If this property is `null`, then [ScrollbarThemeData.thickness] of
  /// [ThemeData.scrollbarTheme] is used to resolve a thickness. If that is
  /// also `null`, the default value is `14.0px`.
  final double? hoverThickness;

  @override
  _NeuScrollbarState createState() => _NeuScrollbarState();
}

class _NeuScrollbarState extends RawScrollbarState<NeuScrollbar> {
  late AnimationController _hoverAnimationController;
  bool _dragIsActive = false;
  bool _hoverIsActive = false;
  late ColorScheme _colorScheme;
  late ScrollbarThemeData _scrollbarTheme;

  Neu get neu => Neu.toggle(
        color: widget.thumbColor ?? _colorScheme.onSurface,
        depth: widget.depth,
        spread: widget.spread,
        lightSource: widget.lightSource,
        depthMultiplier: defaultDepthMultiplier,
        spreadMultiplier: defaultSpreadMultiplier,
      );

  List<Color> get colors =>
      neu.curvature.colorList(neu.color, swell: neu.swell, depth: neu.depth);

  @override
  bool get showScrollbar =>
      widget.isAlwaysShown ?? _scrollbarTheme.isAlwaysShown ?? false;

  @override
  bool get enableGestures =>
      widget.interactive ?? _scrollbarTheme.interactive ?? true;

  bool get _showTrackOnHover =>
      widget.showTrackOnHover ?? _scrollbarTheme.showTrackOnHover ?? false;

  Set<MaterialState> get _states => <MaterialState>{
        if (_dragIsActive) MaterialState.dragged,
        if (_hoverIsActive) MaterialState.hovered,
      };

  MaterialStateProperty<Color> get _thumbColor {
    // final color = widget.thumbColor ?? _colorScheme.onSurface;
    // final brightness = _colorScheme.brightness;
    // late Color dragColor;
    // late Color hoverColor;
    // late Color idleColor;
    // switch (brightness) {
    //   case Brightness.light:
    //     dragColor = color.withOpacity(0.6);
    //     hoverColor = color.withOpacity(0.5);
    //     idleColor = color.withOpacity(0.1);
    //     break;
    //   case Brightness.dark:
    //     dragColor = color.withOpacity(0.75);
    //     hoverColor = color.withOpacity(0.65);
    //     idleColor = color.withOpacity(0.3);
    //     break;
    // }

    final idleColor = colors[1];
    final hoverColor = colors[0];
    final dragColor = colors[2];

    return MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        // if (states.contains(MaterialState.dragged)) return dragColor;
        if (states.contains(MaterialState.dragged)) return idleColor;

        // If the track is visible, the thumb color hover animation is ignored
        // and changes immediately.
        if (states.contains(MaterialState.hovered) && _showTrackOnHover) {
          return hoverColor;
        }
        // Otherwise linerally interpolate.
        return Color.lerp(
          idleColor,
          hoverColor,
          _hoverAnimationController.value,
        )!;
      },
    );
  }

  MaterialStateProperty<Color> get _trackColor {
    // final color = widget.thumbColor ?? _colorScheme.onSurface;
    // final brightness = _colorScheme.brightness;
    return MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        if ((states.contains(MaterialState.hovered) && _showTrackOnHover) ||
            states.contains(MaterialState.dragged)) {
          return colors[2];
          // return _scrollbarTheme.trackColor?.resolve(states) ??
          //     (brightness == Brightness.light
          //         ? color.withOpacity(0.03)
          //         : color.withOpacity(0.05));
        }
        return const Color(0x00000000);
      },
    );
  }

  MaterialStateProperty<Color> get _trackBorderColor {
    // final color = widget.thumbColor ?? _colorScheme.onSurface;
    // final brightness = _colorScheme.brightness;
    return MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        if ((states.contains(MaterialState.hovered) && _showTrackOnHover) ||
            states.contains(MaterialState.dragged)) {
          return colors[0];
          // (Set<MaterialState> states) {
          //  if (states.contains(MaterialState.hovered) && _showTrackOnHover) {
          // return _scrollbarTheme.trackBorderColor?.resolve(states) ??
          //     (brightness == Brightness.light
          //         ? color.withOpacity(0.1)
          //         : color.withOpacity(0.25));
        }
        return const Color(0x00000000);
      },
    );
  }

  MaterialStateProperty<double> get _thickness {
    return MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        if ((states.contains(MaterialState.hovered) && _showTrackOnHover) ||
            states.contains(MaterialState.dragged)) {
          return widget.hoverThickness ??
              _scrollbarTheme.thickness?.resolve(states) ??
              _kScrollbarThicknessWithTrack;
        }
        return widget.thickness ??
            _scrollbarTheme.thickness?.resolve(states) ??
            (_kScrollbarThickness);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _hoverAnimationController.addListener(updateScrollbarPainter);
  }

  @override
  void didChangeDependencies() {
    final theme = Theme.of(context);
    _colorScheme = theme.colorScheme;
    _scrollbarTheme = theme.scrollbarTheme;
    super.didChangeDependencies();
  }

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = _thumbColor.resolve(_states)
      ..trackColor = _trackColor.resolve(_states)
      ..trackBorderColor = _trackBorderColor.resolve(_states)
      ..textDirection = Directionality.of(context)
      ..thickness = _thickness.resolve(_states)
      ..radius = widget.radius ?? _scrollbarTheme.radius ?? _kScrollbarRadius
      ..crossAxisMargin = _scrollbarTheme.crossAxisMargin ?? _kScrollbarMargin
      ..mainAxisMargin = _scrollbarTheme.mainAxisMargin ?? 0.0
      ..minLength = _scrollbarTheme.minThumbLength ?? _kScrollbarMinLength
      ..padding = MediaQuery.of(context).padding;
  }

  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);
    setState(() => _dragIsActive = true);
  }

  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);
    setState(() => _dragIsActive = false);
  }

  @override
  void handleHover(PointerHoverEvent event) {
    super.handleHover(event);
    // Check if the position of the pointer falls over the painted scrollbar
    if (isPointerOverScrollbar(event.position, event.kind)) {
      // Pointer is hovering over the scrollbar
      setState(() => _hoverIsActive = true);
      _hoverAnimationController.forward();
    } else if (_hoverIsActive) {
      // Pointer was, but is no longer over painted scrollbar.
      setState(() => _hoverIsActive = false);
      _hoverAnimationController.reverse();
    }
  }

  @override
  void handleHoverExit(PointerExitEvent event) {
    super.handleHoverExit(event);
    setState(() => _hoverIsActive = false);
    _hoverAnimationController.reverse();
  }

  @override
  void dispose() {
    _hoverAnimationController.dispose();
    super.dispose();
  }
}
