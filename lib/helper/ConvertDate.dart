dateConvert(DateTime data, slice) {
  if (data != null) {
    List dataFormat = data.toLocal().toString().split(slice);
    List dayClean = dataFormat[2].toString().split(' ');
    String dia = dayClean[0];
    String mes = dataFormat[1];
    String ano = dataFormat[0];

    return ("${dia}/${mes}/${ano}");
  } else {
    return '';
  }
}

DateTime dateUtc(DateTime data, slice) {
  if (data != null) {
    List dataFormat = data.toLocal().toString().split(slice);
    List dayClean = dataFormat[2].toString().split(' ');
    String dia = dayClean[0];
    String mes = dataFormat[1];
    String ano = dataFormat[0];

    return DateTime.parse("${ano}-${mes}-${dia}");
  } else {
    return null;
  }
}
