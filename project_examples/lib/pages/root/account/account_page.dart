import 'package:flutter/material.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/pages/base/normal_stateful_widget.dart';

class AccountPage extends NormalStatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

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
