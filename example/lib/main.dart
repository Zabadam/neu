import 'package:flutter/material.dart';

import 'package:neu/neu.dart';

void main() => runApp(const ExampleFrame());

/// [MaterialApp] frame.
class ExampleFrame extends StatelessWidget {
  /// [MaterialApp] frame.
  const ExampleFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Example(),
      );
}

/// Construct a [new Example] `Widget` to fill an [ExampleFrame].
class Example extends StatelessWidget {
  /// Fill an [ExampleFrame] with a [Scaffold] and [AppBar] whose body is a
  /// [PageView]. The `children` of this swiping page view are each built by
  /// [buildView].
  const Example({Key? key}) : super(key: key);

  /// One entire page for a [PageView]. Comprised of a [SingleChildScrollView]
  /// and a [Column].
  Widget buildView({
    required double w,
    required double h,
    required String subtitle,
  }) =>
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            const SizedBox(height: 25),
            Text(
              'Title',
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 20, color: Colors.white),
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
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('neu')),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        children: [
          buildView(
            w: w,
            h: h,
            subtitle: '',
          ),
          buildView(
            w: w,
            h: h,
            subtitle: '',
          ),
        ],
      ),
    );
  }
}
