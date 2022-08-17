import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateful_widget.dart';
import 'package:project_examples/widgets/card_item_widget.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_base_libs_pkg/third_lib_get.dart';
import 'package:project_base_libs_pkg/mod_staggered_grid_view_0_4_0.dart';

class StaggeredGridViewPage extends NormalStatefulWidget {
  const StaggeredGridViewPage({Key? key}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => StaggeredGridViewPageState();
}

class StaggeredGridViewPageState extends NormalStatefulWidgetState<StaggeredGridViewPage> {
  final List<ModStaggeredTile> _tiles = <ModStaggeredTile>[
    const ModStaggeredTile.count(2, 2),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 2),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(4, 1),
    const ModStaggeredTile.count(4, 2),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 4),
    const ModStaggeredTile.count(1, 3),
    const ModStaggeredTile.count(1, 2),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
    const ModStaggeredTile.count(1, 1),
  ];

  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget((Get.arguments as CartItemModel).title),
      );

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: ModSliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            itemCount: _tiles.length,
            staggeredTileBuilder: (int index) => _tiles[index],
            itemBuilder: (BuildContext context, int index) {
              return Container(color: Util.randomOpaqueColor.withOpacity(0.2), alignment: Alignment.center, child: Text(index.toString()));
            },
          ),
        ),
        SliverBoxAdapterSection.widget(
            builder: (d) => const SafeAreaPaddingWidget(type: SafeAreaPadding.bottom, backgroundColor: Colors.transparent)),
      ],
    );
  }
}
