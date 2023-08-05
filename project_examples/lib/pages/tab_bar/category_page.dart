import 'package:project_examples/file_headers.dart';

class CategoryPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const CategoryPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CategoryPageState();
}

class CategoryPageState extends NormalStatefulWidgetState<CategoryPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return Center(child: Text('tab_类目'.tr));
  }
}
