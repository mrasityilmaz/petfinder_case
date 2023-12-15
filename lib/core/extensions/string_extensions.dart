extension StringFormatCheckExtension on String? {
  String get toRouterPath => '/$this';

  String get firstUpper => this != null ? '${this?.substring(0, 1).toUpperCase()}${this?.substring(1)}' : '';
}
