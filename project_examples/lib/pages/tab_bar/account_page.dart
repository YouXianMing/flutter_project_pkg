import 'package:project_examples/file_headers.dart';

class AccountPage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const AccountPage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => AccountPageState();
}

class AccountPageState extends NormalStatefulWidgetState<AccountPage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return const Center(child: Text('Account'));
  }
}
