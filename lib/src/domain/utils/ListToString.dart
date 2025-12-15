String listToString(dynamic data) {
  String msg = '';

  if (data is List<dynamic>) {
    msg = (data as List<dynamic>).join(', ');
  } else {
    msg = data.toString();
  }

  return msg;
}
