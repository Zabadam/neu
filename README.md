# 🆕 neu
## [pub.dev Listing](https://pub.dev/packages/neu) | [API Doc](https://pub.dev/documentation/neu/latest) | [GitHub](https://github.com/Zabadam/neu)
#### API References: [`Neu`](https://pub.dev/documentation/neu/latest/neu/Neu-class.html) | [`NeuContainer`](https://pub.dev/documentation/neu/latest/neu/NeuContainer-class.html) | [`Neu.toggle`](https://pub.dev/documentation/neu/latest/neu/Neu/Neu.toggle.html) | [`NeuToggle`](https://pub.dev/documentation/neu/latest/neu/NeuToggle-class.html) | [`Curvature`](https://pub.dev/documentation/neu/latest/neu/Curvature-class.html) | [`Swell`](https://pub.dev/documentation/neu/latest/neu/Swell-class.html) | [`NeuTextSpec`](https://pub.dev/documentation/neu/latest/neu/NeuTextSpec-class.html)
##### [🐸 Zaba.app ― simple packages, simple names.](#-zabaapp--simple-packages-simple-nameshttpspubdevpublisherszabaapppackages-other-flutter-packages-published-by-zabaapp)
## 🌐 [Interactive Web Demo](https://neu.zaba.app)

|   |   |
|:--|:--|
| [![neu icon](https://neu.zaba.app/img/icon.png)](https://pub.dev/packages/neu 'pub.dev listing') | A ***`Neu`morphic***, or *new [skeuomorphic](https://en.wikipedia.org/wiki/Skeuomorph)*, helper package and class with a variety of static and instance methods for the simple generation of shaded decorations conforming to the neumorphic design concept. |

<!-- [![neu header image](https://neu.zaba.app/img/header_300.gif)](https://pub.dev/packages/neu 'pub.dev listing') -->

These designs are often solid in terms of color variety: generally a
**dominant color** is used as a backdrop as well as the color of controls and
elements. These items would typically appear **on** or "above" the surface with
drop shadows in standard design systems but are intended in neumorphism to
extrude **from** or "rise out" or into the surface.

This extrusion, which can be imagined as *clay*- or *rubber*-like, is achieved
by a combination of same-color elements and background, contrasting shadows,
slight variances in color shading and (potentially) gradients for the impression
of **natural lighting**.

<br />

## 📚 Table of Contents

[![neu logo](https://neu.zaba.app/img/neu.png)](#neu)
  1. [Getting Started](#getting-started 'Getting Started')
  2. [Example](#example 'Example')
     1. [Depth](#depth 'Depth')
     2. [Spread](#spread 'Spread')
     3. [Curvature](#curvature 'Curvature')
     4. [Swell](#swell 'Swell')
     5. [Light Source](#light-source 'Light Source')
  3. [Generating Text Styles](#generating-text-styles 'Generating Text Styles')
  4. [Rapid Deploy with `NeuContainer`](#rapid-deploy-with-neucontainer 'Rapid Deploy with `NeuContainer`')
  5. [Permutations of `Curvature` X `Swell`](#permutations-of-curvature-x-swell 'Permutations of `Curvature` X `Swell`')
  6. 🛣️ [Roadmap](#️-roadmap 'The current TODO list')

<br />

## Getting Started

Create a `new Neu` object. This default constructor has all manner of defaults
in the cases where values are not provided.

```dart
const Neu({
  // Foundation
  Color color = lightWhite,
  int depth = defaultDepth, // 25
  double spread = defaultSpread, // 7.5

  // Fine-tuning
  Curvature curvature = Curvature.convex,
  Swell swell = Swell.emboss,
  Alignment lightSource = defaultLightSource, // Alignment.topLeft
  
  // For specific output method calls
  NeuTextSpec neuTextSpec = const NeuTextSpec(), // buildTextStyle()
  BorderRadius borderRadius = BorderRadius.zero, // buildBoxDecoration()
  ShapeBorder shape = defaultShape, // buildShapeDecoration()
})
```

This `Neu` object has obtainable properties that begin with "build". These
getters call `Neu`'s static methods with parameters filled from the object's
properties. 

Consider [`buildLinearGradient()`](https://pub.dev/documentation/neu/latest/neu/Neu/buildLinearGradient.html)
and [`buildBoxShadows()`](https://pub.dev/documentation/neu/latest/neu/Neu/buildBoxShadows.html);
combinations thereof: [`buildBoxDecoration()`](https://pub.dev/documentation/neu/latest/neu/Neu/buildBoxDecoration.html)
and [`buildShapeDecoration()`](https://pub.dev/documentation/neu/latest/neu/Neu/buildShapeDecoration.html);
or for typography, [`buildTextStyle()`](https://pub.dev/documentation/neu/latest/neu/Neu/buildTextStyle.html).

[![Demonstration of \`Neu.textStyle\`](https://neu.zaba.app/img/textStyle.png)](https://neu.zaba.app 'Goto web demo')

> `buildTextStyle()` with varying `depth` values
 
| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

As mentioned, the above properties call static helper methods by similar names.
These `Neu` static methods may be called at any time without instantiating an
object, like so:

```dart
final BoxDecoration neuDecoration = Neu.boxDecoration(
  color: Colors.indigoAccent.shade700,
  depth: 25,
  spread: 10,
  curvature: Curvature.flat,
  swell: Swell.emboss,
);
```
vs.
```dart
final BoxDecoration neuDecoration = Neu(
  color: Colors.indigoAccent.shade700,
  . . .
).buildBoxDecoration();
```

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

## Example

Click any animation below to experience the 🌐 web demo, which is more or less
equivalent to the source code in the **[Example](https://pub.dev/packages/neu/example)**,
and is the source for the animations.

### Depth

With all `Neu` design the basis of these decorations is a `color` and a `depth`.
Color should ideally match or be similar to the color of the background behind
the resulting decoration. The `depth` is the **extent** to which this decoration
will appear *extruded* from its surface. A larger `depth` increases the contrast
of the shading of colors on either side of the decoration.

[![Demonstration of \`depth\`](https://neu.zaba.app/img/depth.gif)](https://neu.zaba.app 'Goto web demo')

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

### Spread

In terms of shadows, the argument `spread` is responsible for determining how
wide an area the effect covers and how blurry the shadows appear.

Not all methods consider `spread`, notably `linearGradient()` (and
`buildLinearGradient()` by extension) create a decoration―`LinearGradient`―that
does not have shadows. These gradients may be combined with shadows in other
situations, where `spread` will then be considered.

[![Demonstration of \`spread\`](https://neu.zaba.app/img/spread.gif)](https://neu.zaba.app 'Goto web demo')

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

### Curvature

A `Curvature` is a description of the appearance of the actual surface of
the decoration. A `Curvature.flat` decoration has no gradient (or rather, a
solid-color `Gradient`), while `Curvature.convex` orders a light -> dark
gradient in a way that inspires a "bubble"-like appearance.

Other options make the effect more extreme, such as `Curvature.superconvex`,
or reverse the effect: `Curvature.concave`.

See the [twenty permutations of `Curvature` X `Swell`](#permutations-of-curvature-x-swell).

[![Demonstration of \`curvature\`](https://neu.zaba.app/img/curvature.gif)](https://neu.zaba.app 'Goto web demo')

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

### Swell

A `Swell` is an overall depiction of how the decoration appears in terms of
being inset into the surface or extruded from it.

- Combining [Swell.emboss] with [Curvature.convex], the decoration will appear
like a bubble lifting out of the background.

- Combining [Swell.deboss] with [Curvature.concave], the decoration will appear
like a bubble popped and depressed into the background.

This property, especially [when combined with varying `Curvature`s](#permutations-of-curvature-x-swell)
can really "sell" the *pressed* or *unpressed* effect.

[![Demonstration of \`swell\`](https://neu.zaba.app/img/swell.gif)](https://neu.zaba.app 'Goto web demo')

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

### Light Source

The `lightSource` is always set by default as `defaultLightSource`, which is
`Alignment.topLeft`. This gives the illusion of lighting the entire neumorphic
decoration from the top-left corner. All descriptions of gradient and shadow
directionality and the illusion of being *toggled* or *not toggled* are based
on this default light source. An overriding `Alignment` may be provided,
however, to dynamically "relight" the decorations.

- Consider this lighting entirely *artificial*. Aspects of real light physics
  are not recreated. Simply put, this value is used to offset/shift the light
  and dark shadows.

[![Demonstration of \`lightSource\`](https://neu.zaba.app/img/lightSource.gif)](https://neu.zaba.app 'Goto web demo')

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

## Generating Text Styles

When using a `Neu` object and its `buildTextStyle()` property to generate
neumorphic text decorations as opposed to the static method `Neu.textStyle()`,
then instantiate and customize a [`NeuTextSpec` object](https://pub.dev/documentation/neu/latest/neu/NeuTextSpec-class.html)
as well. This secondary parameter container object cleans up the `Neu`
constructor's arguments.

> Other secondary constructor arguments `borderRadius` and `shape` apply to
> instance methods [`buildBoxDecoration()`](https://pub.dev/documentation/neu/latest/neu/Neu/buildBoxDecoration.html)
> and [`buildShapeDecoration()`](https://pub.dev/documentation/neu/latest/neu/Neu/buildShapeDecoration.html)
> respectively.

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

## Rapid Deploy with `NeuContainer`

In some circumstances one may want to place a neumorphic element that does not
already have a solid-matching-color background; or perhaps one would simply
prefer to deploy *`Neu`morphic* decorations with ease and animation support;
in either situation a [`NeuContainer`](https://pub.dev/documentation/neu/latest/neu/NeuContainer/NeuContainer.html)
may come in handy.

This glorified two-layer `AnimatedContainer` has a special `EdgeInsets` property
called [`insets`](https://pub.dev/documentation/neu/latest/neu/NeuContainer/insets.html)
that adds additional padding beyond `padding` with the same color as `color`.

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

##  Permutations of `Curvature` X `Swell`

[![Twenty permutations of \`curvature\` X \`swell\`](https://neu.zaba.app/img/permutations.png)](https://neu.zaba.app 'Goto web demo, swipe to Page 5')

> This is the fifth page (by swiping) in the **Example** app.

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

## 🛣️ Roadmap

- [ ] Bespoke `NeuFoo` pre-built `Widget`s

> Imagine a `NeuAppBar` and tab bar, `NeuScrollbar` or `NeuSlider`.
> 
> At the moment consider `Neu.toggle` named constructor which simplifies the
> customization of neumorphic appearance down to a few `bool` flags. These toggles
> mesh well with the existing paradigm for buttons to appear *pressed* or
> *not pressed*.
> 
> Furthermore [`new NeuToggle`](https://pub.dev/documentation/neu/latest/neu/NeuToggle-class.html)
> may be appropriate for some situations as a `StatefulWidget` that manages its
> own `Neu.toggle` and `GestureDetector`, rendering like an `AnimatedContainer`.
> 
> | Large Widget | Small Widget |
> |:---------------------:|:----------------------:|
> | [![Demonstration of \`NeuToggle\`, large widget](https://neu.zaba.app/img/toggle_big.gif)](https://neu.zaba.app 'Goto web demo') | [![Demonstration of \`NeuToggle\`, small widget](https://neu.zaba.app/img/toggle_small.gif)](https://neu.zaba.app 'Goto web demo') |
> |  |  |
> 
> Each `NeuToggle` includes a `providesFeedback` flag as a convenience shortcut
> for `HapticFeedback.vibrate()` which is `false` by default. 
> 
> Pressing-and-holding (versus a single tap) will call the `onToggle` callback,
> in `void Function(bool isToggled)` format, twice: once when the long-press is
> triggered and again when the long-press is released. The status of the toggle,
> with default normal value of `false`, is the boolean delivered with the
> callback.

- [ ] Debug Props, hash, equality checks, etc.

- [ ] Demo / Example app

> Is already as good as it needs to be, but could be beefed up just a tad to make
> it handy, say, as a generator for decoration code without needing the package.

- [ ] Integration with [`surface`](https://pub.dev/packages/surface)

- [ ] Integration with sensors data for responsive light source

> Planned integration with upcoming package [`sense`](https://pub.dev/packages/sense)
> (around the time existing packages [`xl`](https://pub.dev/packages/xl) and
> [`foil`](https://pub.dev/packages/foil) are transitioned to it).

- [ ] Inner `Shadow`s (may just be achieved through [`surface`](https://pub.dev/packages/surface))

- [ ] Custom `Neu` Painter

- [ ] Interpolation

> Already works pretty well through the nature of these decorations, but bespoke
> tweenage and lerping could be written if it seems helpful at some point.

| ![transparent 600x1 pixel-pusher (ignore)](https://i.imgur.com/XCh0q2K.png) | [📚](#-table-of-contents 'Table of Contents') |
| --------------------------------------------------------------------------: | -------------------------------------------: |

<br />

---

## 🐸 [Zaba.app ― simple packages, simple names.](https://pub.dev/publishers/zaba.app/packages 'Other Flutter packages published by Zaba.app')

<details>
<summary>More by Zaba</summary>

### Wrappers | Widgets that surround other widgets with functionality
- ## 🕹️ [xl](https://pub.dev/packages/xl 'implement accelerometer-fueled interactions with a layering paradigm')
- ## 🌈 [foil](https://pub.dev/packages/foil 'implement accelerometer-reactive gradients in a cinch')
- ## 📜 [curtains](https://pub.dev/packages/curtains 'provide animated shadow decorations for a scrollable to allude to unrevealed content')

---
### Container Widget | Wraps many functionalities in one, very customizable
- ## 🌟 [surface](https://pub.dev/packages/surface 'animated, morphing container with specs for Shape, Appearance, Filter, Tactility')

---
### Succinct Utility | Work great alone or employed above
- ## 🆕 [![neu header](https://neu.zaba.app/img/neu_20.png)](https://pub.dev/packages/neu 'A helper for generating outstanding neumorphic-conforming designs')
- ## 🙋‍♂️ [img](https://pub.dev/packages/img 'An extended Image \"Too\" and DecorationImageToo that support an expanded Repeat.mirror painting mode')
- ## 🙋‍♂️ [icon](https://pub.dev/packages/icon 'An extended Icon \"Too\" for those that are not actually square, plus shadows support + IconUtils')
- ## 🏓 [ball](https://pub.dev/packages/ball 'A bouncy, position-mirroring splash factory that\'s totally customizable')
- ## 👁‍🗨 [sense](https://pub.dev/packages/sense 'A widget that outputs actionable sensors data with intervals, delays, normalization, and more.')
- ## 👥 [shadows](https://pub.dev/packages/shadows 'Convert a double-based \`elevation\` + BoxShadow and List\<BoxShadow\> extensions')
- ## 🎨 [![spectrum header](https://raw.githubusercontent.com/Zabadam/spectrum/main/doc/img/spectrum_15.gif)](https://pub.dev/packages/spectrum 'Color and Gradient utilities such as GradientTween, copyWith, complementary for colors, AnimatedGradient, MaterialColor generation, and more')
</details>
