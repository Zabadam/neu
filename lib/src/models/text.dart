/// Provides [NeuTextSpec] as a container object for [Neu.buildTextStyle]
/// parameters, including a `baseStyle` from which to copy [TextStyle] as well
/// as [Rect] and [TextDirection] fields for painting a gradient atop the text
/// instead of just a solid color.
library neu;

import '../common.dart';
import '../neu.dart';

/// Construct a [new NeuTextSpec] as a container object for [baseStyle] from
/// which to copy [TextStyle] as well as [Rect] and [TextDirection] fields for
/// painting a gradient atop the text instead of just a solid color in the
/// context of [Neu.textStyle] (or more specifically as a field of a [new Neu]
/// object for the deployment of the [Neu.buildTextStyle] instance method).
///
/// Cleans up fields of a [new Neu] object as these three properties contribute
/// to only a single method choice.
class NeuTextSpec {
  /// A container object for [baseStyle] from which to copy [TextStyle] as well
  /// as [Rect] and [TextDirection] fields for painting a gradient atop the text
  /// instead of just a solid color in the context of [Neu.textStyle] (or more
  /// specifically as a field of a [new Neu] object for the deployment of the
  /// [Neu.buildTextStyle] instance method).
  ///
  /// Cleans up fields of a [new Neu] object as these three properties
  /// contribute to only a single method choice.
  const NeuTextSpec({
    this.baseStyle = const TextStyle(),
    this.rect,
    this.textDirection = TextDirection.ltr,
  });

  /// This base style is offered as a convenience. [TextStyle.copyWith] is used
  /// within [Neu.textStyle] beginning with this style and overriding its
  /// [TextStyle.color], [TextStyle.shadows] and potentially
  /// [TextStyle.foreground].
  final TextStyle baseStyle;

  /// A more elaborate *[Neu]morphic* [TextStyle] may render large text with
  /// plenty of room on the glyphs themselves to paint a [Curvature]-inspired
  /// [LinearGradient]. By default, this property is `null` and only a
  /// [TextStyle.color] is supplied--no foreground [Paint] is rendered.
  ///
  /// Offering a [Rect] here for deployment within [Neu.buildTextStyle] as its
  /// [Neu.neuTextSpec] allows [Neu.textStyle] to paint a gradient over the
  /// glyphs as their paint as opposed to a simple flat color.
  final Rect? rect;

  /// Defaults to [TextDirection.ltr]. Relevant only if a [rect] is supplied
  /// to drive a [Paint.shader]-based [LinearGradient] and only then in contexts
  /// where text directionality is considered.
  final TextDirection textDirection;
}
