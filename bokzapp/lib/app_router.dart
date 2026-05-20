import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:readease/features/splash/splash_screen.dart';
import 'package:readease/features/home/home_screen.dart';
import 'package:readease/features/reader_epub/epub_reader_screen.dart';
import 'package:readease/features/reader_pdf/pdf_reader_screen.dart';
import 'package:readease/features/import/import_books_screen.dart';
import 'package:readease/features/collection/collection_screen.dart';
import 'package:readease/features/explore/explore_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/import',
      builder: (context, state) => const ImportBooksScreen(),
    ),
    GoRoute(
      path: '/reader/epub/:id',
      builder: (context, state) {
        final bookId = state.pathParameters['id']!;
        return EpubReaderScreen(bookId: bookId);
      },
    ),
    GoRoute(
      path: '/reader/pdf/:id',
      builder: (context, state) {
        final bookId = state.pathParameters['id']!;
        return PdfReaderScreen(bookId: bookId);
      },
    ),
    GoRoute(
      path: '/collection',
      builder: (context, state) => const CollectionScreen(),
    ),
    GoRoute(
      path: '/explore',
      builder: (context, state) => const ExploreScreen(),
    ),
  ],
);
