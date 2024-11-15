import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promote/common/state_management/app_provider.dart';

class RiverpodProvider {
  static final appProvider =
      ChangeNotifierProvider<AppProvider>((ref) => AppProvider());
}
