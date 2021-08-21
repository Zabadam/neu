/// [![animation demonstrating the example app](https://raw.githubusercontent.com/Zabadam/neu/main/doc/header.gif)](https://pub.dev/packages/neu/example 'animation demonstrating the example app')
///
/// ## [pub.dev Listing](https://pub.dev/packages/neu) | [API Doc](https://pub.dev/documentation/neu/latest) | [GitHub](https://github.com/Zabadam/neu)
/// #### API References: [`Neu`](https://pub.dev/documentation/neu/latest/neu/Neu-class.html) | [`NeuContainer`](https://pub.dev/documentation/neu/latest/neu/NeuContainer-class.html) | [`Neu.toggle`](https://pub.dev/documentation/neu/latest/neu/Neu/Neu.toggle.html) | [`NeuToggle`](https://pub.dev/documentation/neu/latest/neu/NeuToggle-class.html) | [`Curvature`](https://pub.dev/documentation/neu/latest/neu/Curvature-class.html) | [`Swell`](https://pub.dev/documentation/neu/latest/neu/Swell-class.html)
///
/// Introduces a ***[Neu]morphic***, or *new [skeuomorphic](https://en.wikipedia.org/wiki/Skeuomorph)*,
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
/// A [new Neu.toggle] can be setup to automate the changing of appearance based
/// on a state flag, `isToggled`.
///
/// A [NeuContainer] makes deploying a *[Neu]morphic* design element "as easy
/// as pie." A similar container widget that instead makes use of [Neu.toggle]
/// is [NeuToggle].
library neu;

import 'src/neu.dart';
import 'src/widgets/container.dart';
import 'src/widgets/toggle.dart';

export 'src/models/curvature.dart';
// Exported because [CurvatureUtils] and [SwellUtils] each have a public
// `Degree degree` getter:
export 'src/models/degree.dart';
export 'src/models/swell.dart';
export 'src/models/text.dart';
export 'src/neu.dart';
export 'src/widgets/container.dart';
// export 'src/widgets/scrollbar.dart'; // work in progress
export 'src/widgets/toggle.dart';
