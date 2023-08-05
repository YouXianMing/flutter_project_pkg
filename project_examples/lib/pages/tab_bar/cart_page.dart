import 'package:project_examples/file_headers.dart';

class CartPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const CartPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CartPageState();
}

class CartPageState extends NormalStatefulWidgetState<CartPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return Center(child: Text('tab_购物车'.tr));
  }
}
