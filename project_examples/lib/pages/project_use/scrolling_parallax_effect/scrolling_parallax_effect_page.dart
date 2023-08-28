import 'package:project_examples/file_headers.dart';

// 参考: https://docs.flutter.dev/cookbook/effects/parallax-scrolling

class ScrollingParallaxEffectPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ScrollingParallaxEffectPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ScrollingParallaxEffectPageState();
}

class ScrollingParallaxEffectPageState extends NormalStatefulWidgetState<ScrollingParallaxEffectPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget backgroundWidget(BuildContext context) => Container(color: Colors.black);

  @override
  Widget body(BuildContext context) {
    List<Widget> children = [];
    for (final item in items) {
      children.add(ListItemWidget(imageUrl: item.imageUrl));
    }

    return ListView(children: children);
  }
}

class ListItemWidget extends StatelessWidget {
  ListItemWidget({super.key, required this.imageUrl});

  final String imageUrl;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Flow(
        delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context),
          listItemContext: context,
          backgroundImageKey: _backgroundImageKey,
        ),
        children: [
          Image.network(imageUrl, key: _backgroundImageKey, fit: BoxFit.cover),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(listItemBox.size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize = (backgroundImageKey.currentContext!.findRenderObject() as RenderBox).size;
    final listItemSize = context.size;
    final childRect = verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(0, transform: Transform.translate(offset: Offset(0.0, childRect.top)).transform);
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Item {
  const Item({required this.imageUrl});

  final String imageUrl;
}

const urlPrefix = 'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
const items = [
  Item(imageUrl: '$urlPrefix/01-mount-rushmore.jpg'),
  Item(imageUrl: '$urlPrefix/02-singapore.jpg'),
  Item(imageUrl: '$urlPrefix/03-machu-picchu.jpg'),
  Item(imageUrl: '$urlPrefix/04-vitznau.jpg'),
  Item(imageUrl: '$urlPrefix/05-bali.jpg'),
  Item(imageUrl: '$urlPrefix/06-mexico-city.jpg'),
  Item(imageUrl: '$urlPrefix/07-cairo.jpg'),
];
