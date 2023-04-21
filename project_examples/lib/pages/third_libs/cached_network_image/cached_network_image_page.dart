import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_base_libs_pkg/base_file_headers.dart';
import 'package:project_examples/file_headers.dart';

class CachedNetworkImagePage extends NormalStatefulWidget {
  @override
  final PageArguments? arguments;

  const CachedNetworkImagePage({Key? key, this.arguments}) : super(key: key);

  @override
  BaseStatefulWidgetState<BaseStatefulWidget> createWidgetState() => CachedNetworkImagePageState();
}

class CachedNetworkImagePageState extends NormalStatefulWidgetState<CachedNetworkImagePage> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) => NormalAppBar(
        context: context,
        title: NormalAppBar.titleWidget(appGetTitle(arguments: widget.arguments)),
      );

  @override
  Widget body(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: 'https://pic.cnblogs.com/avatar/607542/20151017230728.png',
        placeholder: (context, url) => const Icon(Icons.download),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ).addDebugContainer(borderColor: Colors.blueGrey),
    );
  }
}
