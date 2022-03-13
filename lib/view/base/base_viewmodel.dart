import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final baseState =
    ChangeNotifierProvider<BaseViewmodel>((ref) => BaseViewmodel());

class BaseViewmodel extends ChangeNotifier {
 
}
