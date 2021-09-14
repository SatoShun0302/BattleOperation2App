class ListUtil {

  /// 文字列のリストから、改行を含んだ文字列を作成する.
  static String createSnackBarMessage(List<String> lists) {
    String _message = "";
    lists.forEach((text) {
      _message += "$text\n";
    });
    if (_message.isNotEmpty) {
      _message = _message.substring(0, (_message.length - 1));
    }
    return _message;
  }

  /// リストのlengthを参照し、snackBarのDurationを計算する.
  ///
  /// 1以下:2秒, 2以上4以下:4秒, 5以上7以下:6秒, 8以上10以下:9秒, 11以上:15秒.
  static int calcSnackBarDurationFromListLength(List<String> lists) {
    int _seconds = 0;
    int _length = lists.isNotEmpty ? lists.length : 0;
    if (_length <= 1) {
      _seconds = 2;
    } else if (_length <= 4) {
      _seconds = 4;
    } else if (_length <= 7) {
      _seconds = 6;
    } else if (_length <= 10) {
      _seconds = 9;
    } else {
      _seconds = 15;
    }
    return _seconds;
  }
}