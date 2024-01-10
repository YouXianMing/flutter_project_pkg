import 'package:project_examples/file_headers.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class ScrollviewObserverPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const ScrollviewObserverPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => ScrollviewObserverPageState();
}

class ScrollviewObserverPageState extends NormalStatefulWidgetState<ScrollviewObserverPage> {
  static const double _leadingPadding = 1000;
  static const double _trailingPadding = 2000;
  static const EdgeInsets _padding = EdgeInsets.only(top: _leadingPadding, bottom: _trailingPadding);
  int _hitIndex = 0;
  final ScrollController _scrollController = ScrollController(initialScrollOffset: _leadingPadding);
  late ListObserverController _observerController;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  void initState() {
    super.initState();

    // https://github.com/fluttercandies/flutter_scrollview_observer/tree/main/example/lib/features

    _observerController = ListObserverController(controller: _scrollController)
      ..initialIndexModel = ObserverIndexPositionModel(
        index: 10,
        padding: _padding,
      );

    // Trigger an observation manually
    ambiguate(WidgetsBinding.instance)?.endOfFrame.then((_) {
      // After layout
      if (mounted) _observerController.dispatchOnceObserve();
    });
  }

  @override
  void dispose() {
    _observerController.controller?.dispose();
    super.dispose();
  }

  ListView _buildListView() {
    return ListView.separated(
      padding: _padding,
      controller: _scrollController,
      itemBuilder: (ctx, index) => _buildListItemView(index),
      separatorBuilder: (ctx, index) => _buildSeparatorView(),
      itemCount: 100,
      cacheExtent: double.maxFinite,
    );
  }

  Widget _buildListItemView(int index) {
    return Container(
      height: (index % 2 == 0) ? 80 : 50,
      color: _hitIndex == index ? Colors.red : Colors.black12,
      child: Center(child: Text('index -- $index', style: TextStyle(color: _hitIndex == index ? Colors.white : Colors.black))),
    );
  }

  Container _buildSeparatorView() => Container(color: Colors.white, height: 5);

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: ListViewObserver(
        autoTriggerObserveTypes: const [ObserverAutoTriggerObserveType.scrollEnd],
        triggerOnObserveType: ObserverTriggerOnObserveType.directly,
        controller: _observerController,
        onObserve: (resultModel) {
          debugPrint('visible -- ${resultModel.visible}');
          debugPrint('firstChild.index -- ${resultModel.firstChild?.index}');
          debugPrint('displaying -- ${resultModel.displayingChildIndexList}');

          for (var item in resultModel.displayingChildModelList) {
            debugPrint('item - ${item.index} - ${item.leadingMarginToViewport} - ${item.trailingMarginToViewport}');
          }

          setState(() {
            _hitIndex = resultModel.firstChild?.index ?? 0;
          });
        },
        child: _buildListView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.airline_stops_outlined),
        onPressed: () {
          if (Util.randomBool) {
            _observerController.jumpTo(index: 50, padding: _padding);
          } else {
            _observerController.animateTo(index: 50, duration: const Duration(seconds: 1), curve: Curves.ease, padding: _padding);
          }
        },
      ),
    );
  }
}
