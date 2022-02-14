library project_base_libs_pkg;

/// extensions
export 'base/extensions/widget_extensions.dart'; // Widget的扩展
export 'base/extensions/iterable_extensions.dart'; // 迭代器的扩展
export 'base/extensions/string_extensions.dart'; // String的扩展
export 'base/extensions/global_key_extensions.dart'; // GlobalKey的扩展
export 'base/extensions/curve_extensions.dart'; // Curve的扩展
export 'base/extensions/json_extensions.dart'; // json的便利扩展

/// managers
export 'base/managers/animations_manager.dart'; // 动画管理类
export 'base/managers/page_view_manager.dart'; // PageView用管理器
export 'base/managers/maybe_pop_manager.dart'; // 处理物理返回键的管理器
export 'base/managers/event_bus_manager.dart'; // EventBus工具

/// network
export 'base/network/base_network.dart'; // 网络请求基类
export 'base/network/dio_network.dart'; // dio的网络请求实现

/// other
export 'base/others/sliver_section/base_sliver_section.dart'; // sliverSection基类
export 'base/others/sliver_section/sliver_section.dart'; // sliverSection基类
export 'base/others/sliver_section/sliver_list/sliver_list_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_grid/sliver_grid_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_grid/sliver_grid_cross_axis_extent_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_box_adapter/sliver_box_adapter_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_box_adapter/sliver_horizontal_grid_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_box_adapter/sliver_vertical_grid_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_box_adapter/sliver_wrap_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_persistent_header/sliver_persistent_header_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_app_bar_section/sliver_app_bar_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_list/sliver_fixed_extent_list_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_list/sliver_prototype_extent_list_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_layout_builder/sliver_layout_builder_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_third_libs/sliver_staggered_grid_count_builder_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_third_libs/sliver_quilted_grid_section.dart'; // sliverSection相关
export 'base/others/sliver_section/sliver_third_libs/sliver_waterfall_flow_section.dart'; // sliverSection相关
export 'base/others/widgets_factory.dart'; // 常用widget的工厂类
export 'base/others/staggered_grid_data.dart';
export 'base/others/no_splash_theme.dart';

/// tools
export 'base/tools/app_print.dart'; // 打印
export 'base/tools/hex_color.dart'; // hexColor
export 'base/tools/sp_val.dart'; // 本地存储
export 'base/tools/shared_preferences_util.dart'; // 本地化存储工具
export 'base/tools/util.dart'; // 常用工具
export 'base/tools/dart_semaphore.dart'; // 信号量工具
export 'base/tools/file_util.dart'; // 文件相关处理工具
export 'base/tools/plat_form_info.dart'; // 平台信息
export 'base/tools/scan_files_tool.dart'; // 文件夹扫描工具
export 'base/tools/check_value.dart'; // 检验获取参数的类型

/// widgets
export 'base/widgets/information_view/animated_pop_view.dart'; // InformationView相关
export 'base/widgets/information_view/animated_sheet_view.dart'; // InformationView相关
export 'base/widgets/information_view/animated_simple_toast_view.dart'; // InformationView相关
export 'base/widgets/information_view/animated_widget_factory.dart'; // InformationView相关
export 'base/widgets/information_view/information_view.dart'; // InformationView相关
export 'base/widgets/information_view/information_view_enums_and_configs.dart'; // InformationView相关枚举值以及配置
export 'base/widgets/first_time_loading_widget.dart'; // 首次加载控件
export 'base/widgets/status_widget.dart'; // 点击事件相关的基类
export 'base/widgets/stack_container.dart'; // Stack的容器
export 'base/widgets/safe_area_padding_widget.dart'; // 安全间隙widget
export 'base/widgets/indicators/indicator_widget.dart'; // 菊花控件
export 'base/widgets/indicators/indicator_configs/spin_kit_indicator_config.dart'; // 菊花控件配置
export 'base/widgets/indicators/indicator_configs/tino_guo_indicator_config.dart'; // 菊花控件配置
export 'base/widgets/indicators/indicator_configs/cytryn_indicator_config.dart'; // 菊花控件配置
export 'base/widgets/indicators/indicator_configs/watery_desert_indicator_config.dart'; // 菊花控件配置
export 'base/widgets/custom_wrap_widget.dart'; // 仿制Wrap控件,可以设置宽高
export 'base/widgets/custom_tab_bar_widget.dart'; // 常用自定义TabBar
export 'base/widgets/toast_widget.dart'; // toast
export 'base/widgets/base_stateful_widget.dart'; // statefulWidget基类
export 'base/widgets/base_stateless_widget.dart'; // stateflessWidget基类
export 'base/widgets/staggered_grid_view_count_widget.dart'; // staggered_grid_view_count_widget
export 'base/widgets/sliver_refresh_widget.dart'; // 刷新用控件
export 'base/widgets/base_app_bar.dart'; // appBar
export 'base/widgets/animated_rotate.dart'; // 旋转动画控件
export 'base/widgets/widget_callback_mixin.dart'; // 事件回调mixin
export 'base/widgets/base_page_build_mixin.dart'; // 页面构建mixin
export 'base/widgets/button/base_button_widget.dart'; // 按钮基础控件
export 'base/widgets/button/animated_button_widget.dart'; // 动画按钮控件
export 'base/widgets/button/opacity_button_widget.dart'; // 透明度动画按钮控件
