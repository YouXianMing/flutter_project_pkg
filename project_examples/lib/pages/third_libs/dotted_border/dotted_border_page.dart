import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/base/normal_stateful_widget.dart';
import 'package:project_examples/route/app_route_manager.dart';
import 'package:project_examples/widgets/custom_app_bar.dart';
import 'package:project_examples/app_route_style.dart';
import 'package:dotted_border/dotted_border.dart';

class DottedBorderPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const DottedBorderPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => DottedBorderPageState();
}

class DottedBorderPageState extends NormalStatefulWidgetState<DottedBorderPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: <Widget>[
              rectBorderWidget,
              roundedRectBorderWidget,
              customBorder,
              roundStrokeCap,
              solidBorder,
              fullWidthPath,
            ],
          ),
        ),
      ),
    );
  }

  /// Draw a border with rectangular border
  Widget get rectBorderWidget {
    return DottedBorder(
      dashPattern: const [8, 4],
      strokeWidth: 2,
      child: Container(height: 200, width: 120, color: Colors.red),
    );
  }

  /// Draw a border with a rounded rectangular border
  Widget get roundedRectBorderWidget {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(height: 200, width: 120, color: Colors.amber),
      ),
    );
  }

  /// Draw a border with custom path border
  Widget get customBorder {
    Path customPath = Path()
      ..moveTo(20, 20)
      ..lineTo(50, 100)
      ..lineTo(20, 200)
      ..lineTo(100, 100)
      ..lineTo(20, 20);

    return DottedBorder(
      customPath: (_) => customPath,
      color: Colors.indigo,
      dashPattern: const [8, 4],
      strokeWidth: 2,
      child: Container(height: 220, width: 120, color: Colors.green.withAlpha(20)),
    );
  }

  /// Set border stroke cap
  Widget get roundStrokeCap {
    return DottedBorder(
      dashPattern: const [8, 4],
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: const Radius.circular(5),
      child: Container(height: 200, width: 120, color: Colors.red),
    );
  }

  Widget get solidBorder {
    return DottedBorder(
      dashPattern: const [4, 3],
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      child: Container(color: Colors.green, height: 200, width: 120),
    );
  }

  Widget get fullWidthPath {
    return DottedBorder(
      customPath: (size) {
        return Path()
          ..moveTo(0, 20)
          ..lineTo(size.width, 20);
      },
      child: Padding(padding: const EdgeInsets.all(16.0), child: Container()),
    );
  }
}
