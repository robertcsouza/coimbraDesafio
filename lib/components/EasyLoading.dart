import 'package:flutter_easyloading/flutter_easyloading.dart';

EasyLoading easyLoading() {
  EasyLoading.show(
    status: 'Carregando',
    maskType: EasyLoadingMaskType.black,
  );
}
