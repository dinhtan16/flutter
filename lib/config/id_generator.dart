import 'dart:math';

String generateId(int length) {
  var rand = Random();
  var codeUnits = List.generate(length, (index) {
    return rand.nextInt(26) + 97; // mã ASCII của chữ cái tiếng Anh từ a đến z
  });

  return String.fromCharCodes(codeUnits);
}
