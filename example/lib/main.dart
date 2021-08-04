import 'package:flutter/material.dart';

import 'package:neu/neu.dart';
import 'package:spectrum/spectrum.dart';

void main() => runApp(const ExampleFrame());

/// [MaterialApp] frame.
class ExampleFrame extends StatelessWidget {
  /// [MaterialApp] frame.
  const ExampleFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final color = Colors.purpleAccent.shade200;
    // final color = Colors.purple.shade600;
    // final color = Colors.red.shade700;
    // final color = Colors.blue.shade600;
    final color = Colors.green.shade600;

    // final neu = Neu(color: color, depth: 20);
    // final neuGradient = neu.buildGradient;
    // final neuTextStyle = neu.buildTextStyle;
    // final neuBoxShadows = neu.buildBoxShadows;

    return AnimatedTheme(
      data: ThemeData.from(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: color.asMaterialColor)),
      duration: const Duration(milliseconds: 1500),
      child: Builder(
        builder: (BuildContext _context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          color: color,
          theme: Theme.of(_context),
          home: Example(color),
        ),
      ),
    );
  }
}

/// Construct a [new Example] `Widget` to fill an [ExampleFrame].
class Example extends StatelessWidget {
  /// Fill an [ExampleFrame] with a [Scaffold] and [AppBar] whose body is a
  /// [PageView]. The `children` of this swiping page view are each built by
  /// [buildView].
  const Example(this.color, {Key? key}) : super(key: key);

  final Color color;

  /// One entire page for a [PageView]. Comprised of a [SingleChildScrollView]
  /// and a [Column].
  Widget buildView({
    required double w,
    required double h,
    String title = '',
    String subtitle = '',
    int depth = 10,
  }) =>
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 1500),
              style: Neu.textStyle(
                // color: Colors.blue,
                color: color,
                // spread: 7,
                // depth: 40,
                spread: 10,
                depth: 25,
                // spread: 35,
                // depth: 55,
                swell: Swell.deboss,
                baseStyle: const TextStyle(
                  fontSize: 75,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              child: Text(title),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 1500),
              margin: const EdgeInsets.all(50.0),
              padding: const EdgeInsets.all(50.0),
              decoration: Neu.boxDecoration(
                color: color,
                spread: 20,
              ),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Neu.textStyle(
                  color: color,
                  spread: 5,
                  depth: depth,
                  baseStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: color,
      appBar: AppBar(title: const Text('neu')),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        children: [
          buildView(
            w: w,
            h: h,
            title: 'PAGE 1',
            subtitle: 'dolor sit amet di amor se la vie!',
          ),
          buildView(
            w: w,
            h: h,
            depth: 25,
            title: 'PAGE 2',
            subtitle: 'dolor sit amet di amor se la vie? '
                'dolor sit amet di amor se la vie!',
          ),
        ],
      ),
    );
  }
}
