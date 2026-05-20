import 'package:flutter/material.dart';
import 'package:readease/core/result.dart';

class ReaderTheme {
  final Color backgroundColor;
  final Color textColor;
  final String fontFamily;

  const ReaderTheme({
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.fontFamily = 'Roboto',
  });
}

abstract class BookReader {
  Future<Result<void>> initialize(String filePath);
  Future<Result<void>> goToPosition(String position);
  Future<Result<String>> getCurrentPosition();
  Future<Result<int>> getTotalPages();
  Future<Result<void>> search(String query);
}

abstract class BookReaderController extends ChangeNotifier {
  bool get isLoading;
  double get progress;
  String get currentPosition;
  int get totalPages;
  bool get hasError;
  String? get errorMessage;

  Future<void> initialize(String filePath);
  Future<void> goToPosition(String position);
  Future<void> goToPage(int page);
  Future<void> search(String query);
  Future<void> updateTheme(ReaderTheme theme);
  Future<void> updateFontSize(double size);
}
