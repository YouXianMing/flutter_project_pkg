import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SnappingSheetPage extends NormalStatefulWidget {
  final PageArguments? arguments;

  const SnappingSheetPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => SnappingSheetPageState();
}

class SnappingSheetPageState extends NormalStatefulWidgetState<SnappingSheetPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  @override
  Widget body(BuildContext context) => SimpleSnappingSheet();
}

class SimpleSnappingSheet extends StatelessWidget {
  final ScrollController listViewController = ScrollController();

  SimpleSnappingSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
      lockOverflowDrag: true,
      snappingPositions: const [
        SnappingPosition.factor(
          positionFactor: 0.0,
          snappingCurve: Curves.easeOutExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.top,
        ),
        SnappingPosition.factor(
          snappingCurve: Curves.elasticOut,
          snappingDuration: Duration(milliseconds: 1750),
          positionFactor: 0.3,
        ),
        SnappingPosition.factor(
          snappingCurve: Curves.elasticOut,
          snappingDuration: Duration(milliseconds: 1750),
          positionFactor: 0.6,
        ),
        SnappingPosition.factor(
          grabbingContentOffset: GrabbingContentOffset.bottom,
          snappingCurve: Curves.easeInExpo,
          snappingDuration: Duration(seconds: 1),
          positionFactor: 0.9,
        ),
      ],
      grabbing: const GrabbingWidget(),
      grabbingHeight: 75,
      // sheetAbove: SnappingSheetContent(
      //   draggable: true,
      //   child: Container(color: Colors.grey[200], child: Placeholder(color: Colors.green[200]!)),
      // ),
      sheetBelow: SnappingSheetContent(
        draggable: true,
        childScrollController: listViewController,
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            controller: listViewController,
            itemBuilder: (context, index) => Container(color: Util.randomColor, height: 100, child: Center(child: Text(index.toString()))),
          ),
        ),
      ),
      child: const Background(),
      onSnapStart: (data, position) {
        // appPrint(data);
        // appPrint(position);
      },
      onSheetMoved: (data) {
        // appPrint(data);
      },
      onSnapCompleted: (data, position) {
        // appPrint(data);
        // appPrint(position);
      },
    );
  }
}

/// Widgets below are just helper widgets for this example

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.grey[200], child: Placeholder(color: Colors.green[200]!));
  }
}

class GrabbingWidget extends StatelessWidget {
  const GrabbingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 100,
            height: 7,
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5)),
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
            margin: const EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          )
        ],
      ),
    );
  }
}
