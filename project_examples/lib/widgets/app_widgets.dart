import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

enum ListItemViewType { title, info, normal, image }

class ListItemView extends StatelessWidget {
  final List<ListItemCell> cells;
  const ListItemView({Key? key, required this.cells}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (_, index) => cells[index], itemCount: cells.length);
  }
}

class ListItemCell extends StatelessWidget {
  final Function(String)? onTap;
  final String content;
  final Widget? contentWidget;
  final ListItemViewType type;

  const ListItemCell({
    Key? key,
    required this.content,
    this.onTap,
    this.contentWidget,
    this.type = ListItemViewType.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget retWidget;
    if (type == ListItemViewType.normal) {
      retWidget = GestureDetector(
        onTap: () {
          if (onTap != null) {
            if (onTap != null) onTap!(content);
          }
        },
        child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            //height: 50,
            child: contentWidget ?? Text(content, style: const TextStyle(height: 1.75))),
      );
    } else if (type == ListItemViewType.title) {
      retWidget = Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10),
        height: 50,
        child: Text(
          content,
          style: const TextStyle(color: Colors.blueAccent, fontSize: 18),
        ),
      );
    } else if (type == ListItemViewType.info) {
      retWidget = Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Text(
          content,
          style: const TextStyle(color: Colors.brown, fontSize: 13, height: 1.75),
        ),
      );
    } else if (type == ListItemViewType.image) {
      retWidget = Util.image(content);
    }

    return retWidget;
  }
}
