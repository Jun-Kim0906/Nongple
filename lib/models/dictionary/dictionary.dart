import 'package:meta/meta.dart';

class Dictionary {
  final String wordName;
  final String wordNumber;

  const Dictionary({
    @required this.wordName,@required this.wordNumber,
  });

  factory Dictionary.fromJson(Map<String, dynamic> js) {
    return Dictionary(
      wordName: js['wordName'],
      wordNumber: js['wordNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wordName': wordName,
      'wordNumber' : wordNumber,
    };
  }
}
