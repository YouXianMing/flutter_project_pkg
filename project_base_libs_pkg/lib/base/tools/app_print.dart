import 'package:flutter/foundation.dart';

enum PrintLevel { verbose, debug, info, warning, error }

const int _printTraceIndex = 1;

const bool _isReleasePrintCheck = bool.fromEnvironment('dart.vm.product');

Set<PrintLevel> _printDebugSet = {
  PrintLevel.verbose,
  PrintLevel.debug,
  PrintLevel.info,
  PrintLevel.warning,
  PrintLevel.error,
};

void setAppPrint({Set<PrintLevel> levelsSet = const {}}) {
  _printDebugSet.clear();
  _printDebugSet.addAll(levelsSet);
}

void appPrint(Object? object, {PrintLevel level = PrintLevel.info}) {
  if (_printDebugSet.contains(level) && _isReleasePrintCheck == false) {
    if (kIsWeb) {
      if (level == PrintLevel.info) {
        _printLog('[🔍]:', object);
      } else if (level == PrintLevel.verbose) {
        _printLog('[🖥]:', object);
      } else if (level == PrintLevel.error) {
        _printLog('[❌]:', object);
      } else if (level == PrintLevel.debug) {
        _printLog('[🛠]:', object);
      } else if (level == PrintLevel.warning) {
        _printLog('[⚠️]:', object);
      }
    } else {
      _StackTraceParse tp = _StackTraceParse(StackTrace.current, traceIndex: _printTraceIndex);
      if (level == PrintLevel.info) {
        _printLog('[🔍 ${tp.fileName}]:', object);
      } else if (level == PrintLevel.verbose) {
        _printLog('[🖥 ${tp.fileName}]:', object);
      } else if (level == PrintLevel.error) {
        _printLog('[❌ ${tp.fileName}]:', object);
      } else if (level == PrintLevel.debug) {
        _printLog('[🛠 ${tp.fileName}]:', object);
      } else if (level == PrintLevel.warning) {
        _printLog('[⚠️ ${tp.fileName}]:', object);
      }
    }
  }
}

void appPrintWarning(Object? object) {
  if (_printDebugSet.contains(PrintLevel.warning) && _isReleasePrintCheck == false) {
    if (kIsWeb) {
      _printLog('[⚠️]:', object);
    } else {
      _StackTraceParse tp = _StackTraceParse(StackTrace.current, traceIndex: _printTraceIndex);
      _printLog('[⚠️ ${tp.fileName}]:', object);
    }
  }
}

void appPrintError(Object? object) {
  if (_printDebugSet.contains(PrintLevel.error) && _isReleasePrintCheck == false) {
    if (kIsWeb) {
      _printLog('[❌]:', object);
    } else {
      _StackTraceParse tp = _StackTraceParse(StackTrace.current, traceIndex: _printTraceIndex);
      _printLog('[❌ ${tp.fileName}]:', object);
    }
  }
}

void _printLog(String info, Object? message) {
  StringBuffer sb = StringBuffer();
  sb..write(info)..write(message);
  debugPrint(sb.toString());
}

class _StackTraceParse {
  final StackTrace _trace;
  late String fileName;

  /// 在打印栈中的位置
  int traceIndex;

  _StackTraceParse(this._trace, {required this.traceIndex}) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = _trace.toString().split('\n')[traceIndex];
    var indexOfFileName = traceString.indexOf(RegExp(r'[(].+?[)]'));
    var fileNameStr = traceString.substring(indexOfFileName);
    fileName = fileNameStr.substring(1, fileNameStr.length - 1);
  }
}
