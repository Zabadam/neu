import 'package:flutter/material.dart';

import 'package:neu/neu.dart';
import 'package:spectrum/spectrum.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const DemoFrame());

/// [MaterialApp] frame.
class DemoFrame extends StatelessWidget {
  /// [MaterialApp] frame.
  const DemoFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final color = Colors.purpleAccent.shade200;
    // final color = Colors.purple.shade600;
    // final color = Colors.red.shade700;
    // final color = Colors.blue.shade600;
    // final color = Colors.green.shade600;
    final color = Colors.indigoAccent.shade700;
    // final color = Colors.orange.shade900;
    // final color = Colors.indigo.shade800;

    return AnimatedTheme(
      data: ThemeData.from(
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: color.asMaterialColor),
      ),
      duration: const Duration(milliseconds: 450),
      child: Builder(
        builder: (BuildContext _context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            color: color,
            theme: Theme.of(_context),
            home: Demo(color),
            // home:
            //  const Material(color: Colors.transparent, child: SliderDemo()),
          );
        },
      ),
    );
  }
}

/// Construct a [new Demo] `Widget` to fill a [DemoFrame].
class Demo extends StatelessWidget {
  /// Fill a [DemoFrame] with a [Scaffold] and [AppBar] whose body is a
  /// [PageView]. The `children` of this swiping page view are the customizable
  /// [SliderDemo], two variety of
  /// [buildBigView], and two instances of [buildSmallView]
  const Demo(this.color, {Key? key}) : super(key: key);

  /// This initial color from [DemoFrame] is provided along to [buildBigView]
  /// and [buildSmallView].
  final Color color;

  @override
  Widget build(BuildContext context) {
    final zabaFrog = InkWell(
      onTap: () => launch('https://pub.dev/publishers/zaba.app/packages'),
      child: const FittedBox(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('🐸', style: TextStyle(fontSize: 40)),
        ),
      ),
    );

    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('neu'),
        actions: [zabaFrog],
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        children: [
          SliderDemo(color: color),
          const SliderDemo(),
          Demo0(color),
          Demo1(color),
          Demo2(color),
          Demo3(color),
        ],
      ),
    );
  }
}

/// Construct a [new SliderDemo] to create a page-filling `Widget` with a
/// malleable *[Neu]morphic* design container and several sliders to control
/// its properties. The `spread` property for large text is divided by 2.
class SliderDemo extends StatefulWidget {
  /// A page-filling `Widget` with a malleable *[Neu]morphic* design container
  /// and several sliders to control its properties. The `spread` property for
  /// large text is divided by 2.
  const SliderDemo({Key? key, this.color}) : super(key: key);

  /// If non-`null`, this provided [color] will disable this `Widget`'s "color
  /// slider" and set the visual appearance of the demo to this [color].
  final Color? color;

  @override
  _SliderDemoState createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double colorValue = 0;
  Color get color => widget.color != null
      ? widget.color!
      : Colors.primaries[colorValue.round()];

  double depthValue = 25.0;
  int get depth => depthValue.round();

  double curvatureValue = 2;
  Curvature get curvature => Curvature.values[curvatureValue.round()];

  double swellValue = 2;
  Swell get swell => Swell.values[swellValue.round()];

  double spread = 7.5;

  static const alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerRight,
    Alignment.bottomRight,
    Alignment.bottomCenter,
    Alignment.bottomLeft,
    Alignment.centerLeft,
    Alignment.center,
  ];
  double lightSourceValue = 0;
  Alignment get lightSource => alignments[lightSourceValue.round()];

  @override
  Widget build(BuildContext context) {
    final neuDecoratedContainer = AnimatedContainer(
      decoration: Neu.boxDecoration(
        color: color,
        depth: depth,
        curvature: curvature,
        swell: swell,
        spread: spread,
        lightSource: lightSource,
        borderRadius: BorderRadius.circular(250.0),
      ),
      margin: const EdgeInsets.all(35.0),
      width: 300,
      height: 300,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
    );

    final style = Neu.textStyle(
      baseStyle: const TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
      color: color,
      depth: depth,
      curvature: curvature,
      swell: swell,
      spread: spread / 2,
      lightSource: lightSource,
    );

    final colorSlider = Slider(
      activeColor: color.withWhite(75),
      inactiveColor: Colors.black45,
      label: '$color',
      value: colorValue,
      onChanged: (double slidTo) => setState(() =>
          colorValue = slidTo.clamp(0, Colors.primaries.length).toDouble()),
      max: Colors.primaries.length.toDouble() - 1,
      divisions: Colors.primaries.length,
    );
    final depthSlider = Slider(
      activeColor: color.withWhite(75),
      inactiveColor: Colors.black45,
      label: '$depth',
      value: depthValue,
      onChanged: (double slidTo) => setState(() => depthValue = slidTo),
      min: 1.0,
      max: 255,
      divisions: 255,
    );
    final spreadSlider = Slider(
      activeColor: color.withWhite(75),
      inactiveColor: Colors.black45,
      label: '$spread',
      value: spread,
      onChanged: (double slidTo) => setState(() => spread = slidTo),
      // onChanged: (double slidTo) {},
      // onChangeEnd: (double slidTo) => setState(() => spread = slidTo),
      min: 1.0,
      max: 50,
      divisions: 200,
    );
    final curvatureSlider = Slider(
      activeColor: color.withWhite(75),
      inactiveColor: Colors.black45,
      label: '$curvature',
      value: curvatureValue,
      onChanged: (double slidTo) => setState(() => curvatureValue = slidTo),
      max: 4,
      divisions: 4,
    );
    final swellSlider = Slider(
      activeColor: color.withWhite(75),
      inactiveColor: Colors.black45,
      label: '$swell',
      value: swellValue,
      onChanged: (double slidTo) => setState(() => swellValue = slidTo),
      max: 3,
      divisions: 3,
    );
    final lightSourceSlider = Slider(
      activeColor: color.withWhite(75),
      inactiveColor: Colors.black45,
      label: '$lightSource',
      value: lightSourceValue,
      onChanged: (double slidTo) => setState(() => lightSourceValue = slidTo),
      max: 8,
      divisions: 8,
    );

    SizedBox fixedWidth({double width = 200, required String label}) =>
        SizedBox(width: width, child: FittedBox(child: Text(label)));

    return
        //  AnimatedDefaultTextStyle(
        //   duration: const Duration(milliseconds: 600),
        //   curve: Curves.elasticOut,
        //   style: style,
        //   child:
        AnimatedContainer(
      color: color,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: neuDecoratedContainer),
          const SizedBox(width: 50),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.color == null)
                  Row(children: [fixedWidth(label: 'COLOR:'), colorSlider]),
                Row(children: [fixedWidth(label: 'DEPTH:'), depthSlider]),
                Row(children: [fixedWidth(label: 'SPREAD:'), spreadSlider]),
                Row(children: [
                  fixedWidth(label: 'CURVATURE:'),
                  curvatureSlider
                ]),
                Row(children: [fixedWidth(label: 'SWELL:'), swellSlider]),
                Row(children: [
                  fixedWidth(label: 'LIGHT SOURCE:'),
                  lightSourceSlider,
                ]),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }
}

class Demo0 extends StatelessWidget {
  const Demo0(this.color, {Key? key}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return buildBigView(
      color: color,
      // size: 360.0,
      size: 300.0,
      depth: 20,
      spread: 18.0,
      // lightSource: const Alignment(-2, -2),
      // lightSource: const Alignment(-0.5, -0.5),
      lightSource: Alignment.topLeft,
      // lightSource: Alignment.topRight,
      // lightSource: Alignment.bottomRight,
    );
  }
}

class Demo1 extends StatelessWidget {
  const Demo1(this.color, {Key? key}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return buildBigView(
      isToggles: true,
      color: color,
      // size: 360.0,
      size: 300.0,
      depth: 20,
      spread: 18.0,
      lightSource: Alignment.topLeft,
    );
  }
}

class Demo2 extends StatelessWidget {
  const Demo2(this.color, {Key? key}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return buildSmallView(
      color: color,
      size: 120.0,
      depth: 8,
      spread: 7.5,
    );
  }
}

class Demo3 extends StatelessWidget {
  const Demo3(this.color, {Key? key}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return buildSmallView(
      isToggles: true,
      color: color,
      size: 120.0,
      depth: 8,
      spread: 7.5,
    );
  }
}

class BuildNeuToggle extends StatefulWidget {
  const BuildNeuToggle(
    this.color, {
    Key? key,
    this.size = 120,
    this.text,
    required this.depth,
    required this.spread,
    this.lightSource = Alignment.topLeft,
    required this.textDepth,
  }) : super(key: key);

  final Color color;
  final String? text;
  final double size, spread;
  final int depth, textDepth;
  final Alignment lightSource;

  @override
  _BuildNeuToggleState createState() => _BuildNeuToggleState();
}

class _BuildNeuToggleState extends State<BuildNeuToggle> {
  var isPressed = false;
  @override
  Widget build(BuildContext context) {
    return NeuToggle(
      color: widget.color,
      depth: widget.depth,
      spread: widget.spread,
      // isFlat: true,
      // isSuper: true,

      onToggle: (bool isToggled) => setState(() => isPressed = isToggled),
      providesFeedback: true,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.elasticOut,

      insets: EdgeInsets.zero,
      margin: EdgeInsets.only(
        left: 25 * (widget.size > 150 ? 3 : 1),
        top: 25 * (widget.size > 150 ? 3 : 1),
        right: 25 * (widget.size > 150 ? 3 : 1),
        bottom: 0,
      ),
      width: widget.size,
      height: widget.size,

      lightSource: widget.lightSource,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        // side: BorderSide(width: 0.5, color: widget.color.withWhite(10)),
        side: BorderSide(
          width: isPressed
              ? 0.5
              : widget.size > 200
                  ? 0.5
                  : 1.0,
          color:
              isPressed ? widget.color.withBlack(widget.depth) : widget.color,
        ),
      ),

      /// Child
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: FittedBox(
          child: Text(
            widget.text ?? ' ${isPressed.toString()}   ',
            textAlign: TextAlign.center,
            style: Neu.textStyle(
              // color: widget.color ~/ Colors.black,
              color: widget.color,
              spread: isPressed ? 3 : 8,
              depth: isPressed
                  ? (widget.textDepth * 1.5).round()
                  : widget.textDepth,
              swell: isPressed ? Swell.superdeboss : Swell.emboss,
              baseStyle: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildNeu(
  Color color, {
  double size = 120,
  String text = '',
  required int depth,
  required double spread,
  required Curvature curvature,
  required Swell swell,
  Alignment lightSource = Alignment.topLeft,
  required int textDepth,
}) {
  final neuObject = Neu(
    // final neuObject = Neu.toggle(
    color: color,
    depth: depth,
    spread: spread,

    /// These parameters (curvature and swell) for `Neu.toggle` are handled
    /// dynamically by the below flags.
    curvature: curvature,
    swell: swell,

    /// These flags are only valid for `Neu.toggle` where they drive the
    /// curvature and swell based on true or false states.
    // isPressed: isPressed,
    // isFlat: true,
    // isSuper: true,

    lightSource: lightSource,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
      // side: BorderSide(width: 0.5, color: color.withWhite(10)),
      // side: BorderSide(width: 0.5, color: color),
    ),
  );

  return AnimatedContainer(
    duration: const Duration(milliseconds: 450),
    margin: EdgeInsets.only(
      left: 25 * (size > 150 ? 3 : 1),
      top: 25 * (size > 150 ? 3 : 1),
      right: 25 * (size > 150 ? 3 : 1),
      bottom: 0,
    ),
    width: size,
    height: size,
    decoration: neuObject.buildShapeDecoration,
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: FittedBox(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Neu.textStyle(
            // color: color ~/ Colors.black,
            color: color,
            spread: textDepth < 30 ? 5 : 4,
            depth: textDepth,
            // swell: Swell.superemboss,
            swell: swell,
            baseStyle: const TextStyle(
              fontSize: 40, // fontSize impacts the [Shadow]s underneath
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    ),
  );
}

/// One entire page for a [PageView]. Comprised of a [SingleChildScrollView]
/// and a [Column].
Widget buildBigView({
  bool isToggles = false,
  required Color color,
  required double size,
  required int depth,
  required double spread,
  required Alignment lightSource,
  String text = 'Text',
  int textDepth = 25,
}) {
  const texts = [
    'Swell.superemboss\nCurvature.superconcave',
    'Swell.superemboss\nCurvature.concave',
    'Swell.superemboss\nCurvature.flat',
    'Swell.superemboss\nCurvature.convex',
    'Swell.superemboss\nCurvature.superconvex',
    'Swell.emboss\nCurvature.superconcave',
    'Swell.emboss\nCurvature.concave',
    'Swell.emboss\nCurvature.flat',
    'Swell.emboss\nCurvature.convex',
    'Swell.emboss\nCurvature.superconvex',
    'Swell.deboss\nCurvature.superconcave',
    'Swell.deboss\nCurvature.concave',
    'Swell.deboss\nCurvature.flat',
    'Swell.deboss\nCurvature.convex',
    'Swell.deboss\nCurvature.superconvex',
    'Swell.superdeboss\nCurvature.superconcave',
    'Swell.superdeboss\nCurvature.concave',
    'Swell.superdeboss\nCurvature.flat',
    'Swell.superdeboss\nCurvature.convex',
    'Swell.superdeboss\nCurvature.superconvex',
  ];
  const curvatures = [
    Curvature.superconcave,
    Curvature.concave,
    Curvature.flat,
    Curvature.convex,
    Curvature.superconvex,
    Curvature.superconcave,
    Curvature.concave,
    Curvature.flat,
    Curvature.convex,
    Curvature.superconvex,
    Curvature.superconcave,
    Curvature.concave,
    Curvature.flat,
    Curvature.convex,
    Curvature.superconvex,
    Curvature.superconcave,
    Curvature.concave,
    Curvature.flat,
    Curvature.convex,
    Curvature.superconvex,
  ];
  const swells = [
    Swell.superemboss,
    Swell.superemboss,
    Swell.superemboss,
    Swell.superemboss,
    Swell.superemboss,
    Swell.emboss,
    Swell.emboss,
    Swell.emboss,
    Swell.emboss,
    Swell.emboss,
    Swell.deboss,
    Swell.deboss,
    Swell.deboss,
    Swell.deboss,
    Swell.deboss,
    Swell.superdeboss,
    Swell.superdeboss,
    Swell.superdeboss,
    Swell.superdeboss,
    Swell.superdeboss,
  ];

  return SingleChildScrollView(
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (var count = 0; count < texts.length; count++)
          isToggles
              ? BuildNeuToggle(
                  color,
                  size: size,
                  lightSource: lightSource,
                  // text: texts[count],
                  depth: depth,
                  spread: spread,
                  textDepth: textDepth,
                )
              : buildNeu(
                  color,
                  size: size,
                  lightSource: lightSource,
                  text: texts[count],
                  depth: depth,
                  spread: spread,
                  curvature: curvatures[count],
                  swell: swells[count],
                  textDepth: textDepth,
                ),

        ///
        const SizedBox(width: 1000, height: 75),
      ],
    ),
  );
}

/// One entire page for a [PageView]. Comprised of a [SingleChildScrollView]
/// and a [Column].
Widget buildSmallView({
  bool isToggles = false,
  required Color color,
  required double size,
  required int depth,
  required double spread,
  String text = '',
  int textDepth = 40,
}) {
  const sizedBox = SizedBox(width: 1000, height: 50);

  const texts = [
    'Swell.\nsuperemboss\n\nCurvature.\nsuperconcave',
    'Swell.\nsuperemboss\n\nCurvature.\nconcave',
    'Swell.\nsuperemboss\n\nCurvature.\nflat',
    'Swell.\nsuperemboss\n\nCurvature.\nflat',
    'Swell.\nsuperemboss\n\nCurvature.\nconvex',
    'Swell.\nsuperemboss\n\nCurvature.\nsuperconvex',
    'Swell.\nemboss\n\nCurvature.\nsuperconcave',
    'Swell.\nemboss\n\nCurvature.\nconcave',
    'Swell.\nemboss\n\nCurvature.\nflat',
    'Swell.\nemboss\n\nCurvature.\nflat',
    'Swell.\nemboss\n\nCurvature.\nconvex',
    'Swell.\nemboss\n\nCurvature.\nsuperconvex',
    'Swell.\ndeboss\n\nCurvature.\nsuperconcave',
    'Swell.\ndeboss\n\nCurvature.\nconcave',
    'Swell.\ndeboss\n\nCurvature.\nflat',
    'Swell.\ndeboss\n\nCurvature.\nflat',
    'Swell.\ndeboss\n\nCurvature.\nconvex',
    'Swell.\ndeboss\n\nCurvature.\nsuperconvex',
    'Swell.\nsuperdeboss\n\nCurvature.\nsuperconcave',
    'Swell.\nsuperdeboss\n\nCurvature.\nconcave',
    'Swell.\nsuperdeboss\n\nCurvature.\nflat',
    'Swell.\nsuperdeboss\n\nCurvature.\nflat',
    'Swell.\nsuperdeboss\n\nCurvature.\nconvex',
    'Swell.\nsuperdeboss\n\nCurvature.\nsuperconvex',
  ];
  const curvatures = [
    Curvature.superconcave,
    Curvature.concave,
    Curvature.flat,
    Curvature.flat,
    Curvature.convex,
    Curvature.superconvex,
    Curvature.superconcave,
    Curvature.concave,
    Curvature.flat,
    Curvature.flat,
    Curvature.convex,
    Curvature.superconvex,
    Curvature.superconcave,
    Curvature.concave,
    Curvature.flat,
    Curvature.flat,
    Curvature.convex,
    Curvature.superconvex,
    Curvature.superconcave,
    Curvature.concave,
    Curvature.flat,
    Curvature.flat,
    Curvature.convex,
    Curvature.superconvex,
  ];
  const swells = [
    Swell.superemboss,
    Swell.superemboss,
    Swell.superemboss,
    Swell.superemboss,
    Swell.superemboss,
    Swell.superemboss,
    Swell.emboss,
    Swell.emboss,
    Swell.emboss,
    Swell.emboss,
    Swell.emboss,
    Swell.emboss,
    Swell.deboss,
    Swell.deboss,
    Swell.deboss,
    Swell.deboss,
    Swell.deboss,
    Swell.deboss,
    Swell.superdeboss,
    Swell.superdeboss,
    Swell.superdeboss,
    Swell.superdeboss,
    Swell.superdeboss,
    Swell.superdeboss,
  ];

  return SingleChildScrollView(
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (var count = 0; count < texts.length; count++)
          isToggles
              ? BuildNeuToggle(
                  color,
                  size: size,
                  // text: texts[count],
                  depth: depth,
                  spread: spread,
                  textDepth: textDepth,
                )
              : buildNeu(
                  color,
                  size: size,
                  text: texts[count],
                  depth: depth,
                  spread: spread,
                  curvature: curvatures[count],
                  swell: swells[count],
                  textDepth: textDepth,
                ),
      ]
        ..insert(0, sizedBox)
        ..insert(7, sizedBox)
        ..insert(14, sizedBox)
        ..insert(21, sizedBox)
        ..insert(28, sizedBox),
    ),
  );
}
