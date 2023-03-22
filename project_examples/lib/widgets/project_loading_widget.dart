import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';

enum ProjectLoadingWidgetType {
  loading,
  error,
}

class ProjectLoadingWidget extends StatelessWidget {
  final ProjectLoadingWidgetType type;
  final Function? onTap;

  const ProjectLoadingWidget({super.key, required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ProjectLoadingWidgetType.loading:
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: IndicatorWidget(
            config: WateryDesertIndicatorConfig(
              indicatorType: WateryDesertIndicatorType.staggeredDotsWave,
              size: 50,
              color: Colors.blueAccent,
            ),
          ),
        );

      case ProjectLoadingWidgetType.error:
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_rounded, color: Colors.yellow, size: 60),
              WidgetsFactory.text('很抱歉,出错啦', fontSize: 20, color: Colors.black).addPaddingOnly(bottom: 40),
              OpacityButtonWidget(
                onTap: () {
                  if (onTap != null) onTap!();
                },
                child: WidgetsFactory.text('点击重试', fontSize: 20, color: Colors.white).addContainerBorderRadius(
                  radius: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        );
    }
  }
}
