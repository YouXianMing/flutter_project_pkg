import 'dart:io';
import 'package:flutter/foundation.dart';

// 参考 https://pub.dev/packages/maps_launcher
// 配合 https://pub.dev/packages/url_launcher 可以直接在app里打开地图

class MapUriCreator {
  /// 根据给定的地址字符串创建uri
  /// Returns a URL that can be launched on the current platform
  /// to open a maps application showing the result of a search query.
  static String createQueryUrl(String query, {bool useWebTypeUrl = false}) {
    late Uri uri;

    if (kIsWeb || useWebTypeUrl) {
      uri = Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': query});
    } else if (Platform.isAndroid) {
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      uri = Uri.https('maps.apple.com', '/', {'q': query});
    } else {
      uri = Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': query});
    }

    return uri.toString();
  }

  /// 根据给定的经纬度创建uri
  /// Returns a URL that can be launched on the current platform
  /// to open a maps application showing coordinates ([latitude] and [longitude]).
  static String createCoordinatesUrl(double latitude, double longitude, {String? label, bool useWebTypeUrl = false}) {
    late Uri uri;

    if (kIsWeb || useWebTypeUrl) {
      uri = Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': '$latitude,$longitude'});
    } else if (Platform.isAndroid) {
      var query = '$latitude,$longitude';
      if (label != null) query += '($label)';
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      var params = {'ll': '$latitude,$longitude'};
      if (label != null) params['q'] = label;
      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      uri = Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': '$latitude,$longitude'});
    }

    return uri.toString();
  }
}
