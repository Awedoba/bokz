// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
      'hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedColumn<String> series = GeneratedColumn<String>(
      'series', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<BookType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<BookType>($BooksTable.$convertertype);
  static const VerificationMeta _coverPathMeta =
      const VerificationMeta('coverPath');
  @override
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
      'cover_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _durationSecMeta =
      const VerificationMeta('durationSec');
  @override
  late final GeneratedColumn<int> durationSec = GeneratedColumn<int>(
      'duration_sec', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _pageCountMeta =
      const VerificationMeta('pageCount');
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
      'page_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastOpenedAtMeta =
      const VerificationMeta('lastOpenedAt');
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
      'last_opened_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        path,
        hash,
        title,
        author,
        series,
        genre,
        tags,
        type,
        coverPath,
        durationSec,
        pageCount,
        addedAt,
        lastOpenedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(Insertable<Book> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('hash')) {
      context.handle(
          _hashMeta, hash.isAcceptableOrUnknown(data['hash']!, _hashMeta));
    } else if (isInserting) {
      context.missing(_hashMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('series')) {
      context.handle(_seriesMeta,
          series.isAcceptableOrUnknown(data['series']!, _seriesMeta));
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('cover_path')) {
      context.handle(_coverPathMeta,
          coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta));
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
          _durationSecMeta,
          durationSec.isAcceptableOrUnknown(
              data['duration_sec']!, _durationSecMeta));
    }
    if (data.containsKey('page_count')) {
      context.handle(_pageCountMeta,
          pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta));
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
          _lastOpenedAtMeta,
          lastOpenedAt.isAcceptableOrUnknown(
              data['last_opened_at']!, _lastOpenedAtMeta));
    } else if (isInserting) {
      context.missing(_lastOpenedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      hash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hash'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      series: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}series']),
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      type: $BooksTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      coverPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_path']),
      durationSec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_sec']),
      pageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_count']),
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at'])!,
      lastOpenedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_opened_at'])!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BookType, String, String> $convertertype =
      const EnumNameConverter<BookType>(BookType.values);
}

class Book extends DataClass implements Insertable<Book> {
  final String id;
  final String path;
  final String hash;
  final String title;
  final String author;
  final String? series;
  final String? genre;
  final String tags;
  final BookType type;
  final String? coverPath;
  final int? durationSec;
  final int? pageCount;
  final DateTime addedAt;
  final DateTime lastOpenedAt;
  const Book(
      {required this.id,
      required this.path,
      required this.hash,
      required this.title,
      required this.author,
      this.series,
      this.genre,
      required this.tags,
      required this.type,
      this.coverPath,
      this.durationSec,
      this.pageCount,
      required this.addedAt,
      required this.lastOpenedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['path'] = Variable<String>(path);
    map['hash'] = Variable<String>(hash);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    if (!nullToAbsent || series != null) {
      map['series'] = Variable<String>(series);
    }
    if (!nullToAbsent || genre != null) {
      map['genre'] = Variable<String>(genre);
    }
    map['tags'] = Variable<String>(tags);
    {
      map['type'] = Variable<String>($BooksTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || coverPath != null) {
      map['cover_path'] = Variable<String>(coverPath);
    }
    if (!nullToAbsent || durationSec != null) {
      map['duration_sec'] = Variable<int>(durationSec);
    }
    if (!nullToAbsent || pageCount != null) {
      map['page_count'] = Variable<int>(pageCount);
    }
    map['added_at'] = Variable<DateTime>(addedAt);
    map['last_opened_at'] = Variable<DateTime>(lastOpenedAt);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      path: Value(path),
      hash: Value(hash),
      title: Value(title),
      author: Value(author),
      series:
          series == null && nullToAbsent ? const Value.absent() : Value(series),
      genre:
          genre == null && nullToAbsent ? const Value.absent() : Value(genre),
      tags: Value(tags),
      type: Value(type),
      coverPath: coverPath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPath),
      durationSec: durationSec == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSec),
      pageCount: pageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(pageCount),
      addedAt: Value(addedAt),
      lastOpenedAt: Value(lastOpenedAt),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<String>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      hash: serializer.fromJson<String>(json['hash']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      series: serializer.fromJson<String?>(json['series']),
      genre: serializer.fromJson<String?>(json['genre']),
      tags: serializer.fromJson<String>(json['tags']),
      type: $BooksTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      coverPath: serializer.fromJson<String?>(json['coverPath']),
      durationSec: serializer.fromJson<int?>(json['durationSec']),
      pageCount: serializer.fromJson<int?>(json['pageCount']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
      lastOpenedAt: serializer.fromJson<DateTime>(json['lastOpenedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'path': serializer.toJson<String>(path),
      'hash': serializer.toJson<String>(hash),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'series': serializer.toJson<String?>(series),
      'genre': serializer.toJson<String?>(genre),
      'tags': serializer.toJson<String>(tags),
      'type':
          serializer.toJson<String>($BooksTable.$convertertype.toJson(type)),
      'coverPath': serializer.toJson<String?>(coverPath),
      'durationSec': serializer.toJson<int?>(durationSec),
      'pageCount': serializer.toJson<int?>(pageCount),
      'addedAt': serializer.toJson<DateTime>(addedAt),
      'lastOpenedAt': serializer.toJson<DateTime>(lastOpenedAt),
    };
  }

  Book copyWith(
          {String? id,
          String? path,
          String? hash,
          String? title,
          String? author,
          Value<String?> series = const Value.absent(),
          Value<String?> genre = const Value.absent(),
          String? tags,
          BookType? type,
          Value<String?> coverPath = const Value.absent(),
          Value<int?> durationSec = const Value.absent(),
          Value<int?> pageCount = const Value.absent(),
          DateTime? addedAt,
          DateTime? lastOpenedAt}) =>
      Book(
        id: id ?? this.id,
        path: path ?? this.path,
        hash: hash ?? this.hash,
        title: title ?? this.title,
        author: author ?? this.author,
        series: series.present ? series.value : this.series,
        genre: genre.present ? genre.value : this.genre,
        tags: tags ?? this.tags,
        type: type ?? this.type,
        coverPath: coverPath.present ? coverPath.value : this.coverPath,
        durationSec: durationSec.present ? durationSec.value : this.durationSec,
        pageCount: pageCount.present ? pageCount.value : this.pageCount,
        addedAt: addedAt ?? this.addedAt,
        lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
      hash: data.hash.present ? data.hash.value : this.hash,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      series: data.series.present ? data.series.value : this.series,
      genre: data.genre.present ? data.genre.value : this.genre,
      tags: data.tags.present ? data.tags.value : this.tags,
      type: data.type.present ? data.type.value : this.type,
      coverPath: data.coverPath.present ? data.coverPath.value : this.coverPath,
      durationSec:
          data.durationSec.present ? data.durationSec.value : this.durationSec,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
      lastOpenedAt: data.lastOpenedAt.present
          ? data.lastOpenedAt.value
          : this.lastOpenedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('hash: $hash, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('series: $series, ')
          ..write('genre: $genre, ')
          ..write('tags: $tags, ')
          ..write('type: $type, ')
          ..write('coverPath: $coverPath, ')
          ..write('durationSec: $durationSec, ')
          ..write('pageCount: $pageCount, ')
          ..write('addedAt: $addedAt, ')
          ..write('lastOpenedAt: $lastOpenedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, path, hash, title, author, series, genre,
      tags, type, coverPath, durationSec, pageCount, addedAt, lastOpenedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.path == this.path &&
          other.hash == this.hash &&
          other.title == this.title &&
          other.author == this.author &&
          other.series == this.series &&
          other.genre == this.genre &&
          other.tags == this.tags &&
          other.type == this.type &&
          other.coverPath == this.coverPath &&
          other.durationSec == this.durationSec &&
          other.pageCount == this.pageCount &&
          other.addedAt == this.addedAt &&
          other.lastOpenedAt == this.lastOpenedAt);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<String> id;
  final Value<String> path;
  final Value<String> hash;
  final Value<String> title;
  final Value<String> author;
  final Value<String?> series;
  final Value<String?> genre;
  final Value<String> tags;
  final Value<BookType> type;
  final Value<String?> coverPath;
  final Value<int?> durationSec;
  final Value<int?> pageCount;
  final Value<DateTime> addedAt;
  final Value<DateTime> lastOpenedAt;
  final Value<int> rowid;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.hash = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.series = const Value.absent(),
    this.genre = const Value.absent(),
    this.tags = const Value.absent(),
    this.type = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooksCompanion.insert({
    required String id,
    required String path,
    required String hash,
    required String title,
    required String author,
    this.series = const Value.absent(),
    this.genre = const Value.absent(),
    required String tags,
    required BookType type,
    this.coverPath = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.pageCount = const Value.absent(),
    required DateTime addedAt,
    required DateTime lastOpenedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        path = Value(path),
        hash = Value(hash),
        title = Value(title),
        author = Value(author),
        tags = Value(tags),
        type = Value(type),
        addedAt = Value(addedAt),
        lastOpenedAt = Value(lastOpenedAt);
  static Insertable<Book> custom({
    Expression<String>? id,
    Expression<String>? path,
    Expression<String>? hash,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? series,
    Expression<String>? genre,
    Expression<String>? tags,
    Expression<String>? type,
    Expression<String>? coverPath,
    Expression<int>? durationSec,
    Expression<int>? pageCount,
    Expression<DateTime>? addedAt,
    Expression<DateTime>? lastOpenedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (hash != null) 'hash': hash,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (series != null) 'series': series,
      if (genre != null) 'genre': genre,
      if (tags != null) 'tags': tags,
      if (type != null) 'type': type,
      if (coverPath != null) 'cover_path': coverPath,
      if (durationSec != null) 'duration_sec': durationSec,
      if (pageCount != null) 'page_count': pageCount,
      if (addedAt != null) 'added_at': addedAt,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooksCompanion copyWith(
      {Value<String>? id,
      Value<String>? path,
      Value<String>? hash,
      Value<String>? title,
      Value<String>? author,
      Value<String?>? series,
      Value<String?>? genre,
      Value<String>? tags,
      Value<BookType>? type,
      Value<String?>? coverPath,
      Value<int?>? durationSec,
      Value<int?>? pageCount,
      Value<DateTime>? addedAt,
      Value<DateTime>? lastOpenedAt,
      Value<int>? rowid}) {
    return BooksCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      hash: hash ?? this.hash,
      title: title ?? this.title,
      author: author ?? this.author,
      series: series ?? this.series,
      genre: genre ?? this.genre,
      tags: tags ?? this.tags,
      type: type ?? this.type,
      coverPath: coverPath ?? this.coverPath,
      durationSec: durationSec ?? this.durationSec,
      pageCount: pageCount ?? this.pageCount,
      addedAt: addedAt ?? this.addedAt,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (series.present) {
      map['series'] = Variable<String>(series.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($BooksTable.$convertertype.toSql(type.value));
    }
    if (coverPath.present) {
      map['cover_path'] = Variable<String>(coverPath.value);
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('hash: $hash, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('series: $series, ')
          ..write('genre: $genre, ')
          ..write('tags: $tags, ')
          ..write('type: $type, ')
          ..write('coverPath: $coverPath, ')
          ..write('durationSec: $durationSec, ')
          ..write('pageCount: $pageCount, ')
          ..write('addedAt: $addedAt, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingPositionsTable extends ReadingPositions
    with TableInfo<$ReadingPositionsTable, ReadingPosition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingPositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES books (id)'));
  static const VerificationMeta _cfiMeta = const VerificationMeta('cfi');
  @override
  late final GeneratedColumn<String> cfi = GeneratedColumn<String>(
      'cfi', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _audioSecMeta =
      const VerificationMeta('audioSec');
  @override
  late final GeneratedColumn<int> audioSec = GeneratedColumn<int>(
      'audio_sec', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [bookId, cfi, page, audioSec, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_positions';
  @override
  VerificationContext validateIntegrity(Insertable<ReadingPosition> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('cfi')) {
      context.handle(
          _cfiMeta, cfi.isAcceptableOrUnknown(data['cfi']!, _cfiMeta));
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    }
    if (data.containsKey('audio_sec')) {
      context.handle(_audioSecMeta,
          audioSec.isAcceptableOrUnknown(data['audio_sec']!, _audioSecMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookId};
  @override
  ReadingPosition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingPosition(
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
      cfi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cfi']),
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page']),
      audioSec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}audio_sec']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ReadingPositionsTable createAlias(String alias) {
    return $ReadingPositionsTable(attachedDatabase, alias);
  }
}

class ReadingPosition extends DataClass implements Insertable<ReadingPosition> {
  final String bookId;
  final String? cfi;
  final int? page;
  final int? audioSec;
  final DateTime updatedAt;
  const ReadingPosition(
      {required this.bookId,
      this.cfi,
      this.page,
      this.audioSec,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['book_id'] = Variable<String>(bookId);
    if (!nullToAbsent || cfi != null) {
      map['cfi'] = Variable<String>(cfi);
    }
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    if (!nullToAbsent || audioSec != null) {
      map['audio_sec'] = Variable<int>(audioSec);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReadingPositionsCompanion toCompanion(bool nullToAbsent) {
    return ReadingPositionsCompanion(
      bookId: Value(bookId),
      cfi: cfi == null && nullToAbsent ? const Value.absent() : Value(cfi),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
      audioSec: audioSec == null && nullToAbsent
          ? const Value.absent()
          : Value(audioSec),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReadingPosition.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingPosition(
      bookId: serializer.fromJson<String>(json['bookId']),
      cfi: serializer.fromJson<String?>(json['cfi']),
      page: serializer.fromJson<int?>(json['page']),
      audioSec: serializer.fromJson<int?>(json['audioSec']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookId': serializer.toJson<String>(bookId),
      'cfi': serializer.toJson<String?>(cfi),
      'page': serializer.toJson<int?>(page),
      'audioSec': serializer.toJson<int?>(audioSec),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReadingPosition copyWith(
          {String? bookId,
          Value<String?> cfi = const Value.absent(),
          Value<int?> page = const Value.absent(),
          Value<int?> audioSec = const Value.absent(),
          DateTime? updatedAt}) =>
      ReadingPosition(
        bookId: bookId ?? this.bookId,
        cfi: cfi.present ? cfi.value : this.cfi,
        page: page.present ? page.value : this.page,
        audioSec: audioSec.present ? audioSec.value : this.audioSec,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ReadingPosition copyWithCompanion(ReadingPositionsCompanion data) {
    return ReadingPosition(
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      cfi: data.cfi.present ? data.cfi.value : this.cfi,
      page: data.page.present ? data.page.value : this.page,
      audioSec: data.audioSec.present ? data.audioSec.value : this.audioSec,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingPosition(')
          ..write('bookId: $bookId, ')
          ..write('cfi: $cfi, ')
          ..write('page: $page, ')
          ..write('audioSec: $audioSec, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bookId, cfi, page, audioSec, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingPosition &&
          other.bookId == this.bookId &&
          other.cfi == this.cfi &&
          other.page == this.page &&
          other.audioSec == this.audioSec &&
          other.updatedAt == this.updatedAt);
}

class ReadingPositionsCompanion extends UpdateCompanion<ReadingPosition> {
  final Value<String> bookId;
  final Value<String?> cfi;
  final Value<int?> page;
  final Value<int?> audioSec;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ReadingPositionsCompanion({
    this.bookId = const Value.absent(),
    this.cfi = const Value.absent(),
    this.page = const Value.absent(),
    this.audioSec = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingPositionsCompanion.insert({
    required String bookId,
    this.cfi = const Value.absent(),
    this.page = const Value.absent(),
    this.audioSec = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : bookId = Value(bookId),
        updatedAt = Value(updatedAt);
  static Insertable<ReadingPosition> custom({
    Expression<String>? bookId,
    Expression<String>? cfi,
    Expression<int>? page,
    Expression<int>? audioSec,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (bookId != null) 'book_id': bookId,
      if (cfi != null) 'cfi': cfi,
      if (page != null) 'page': page,
      if (audioSec != null) 'audio_sec': audioSec,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingPositionsCompanion copyWith(
      {Value<String>? bookId,
      Value<String?>? cfi,
      Value<int?>? page,
      Value<int?>? audioSec,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ReadingPositionsCompanion(
      bookId: bookId ?? this.bookId,
      cfi: cfi ?? this.cfi,
      page: page ?? this.page,
      audioSec: audioSec ?? this.audioSec,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (cfi.present) {
      map['cfi'] = Variable<String>(cfi.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (audioSec.present) {
      map['audio_sec'] = Variable<int>(audioSec.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingPositionsCompanion(')
          ..write('bookId: $bookId, ')
          ..write('cfi: $cfi, ')
          ..write('page: $page, ')
          ..write('audioSec: $audioSec, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES books (id)'));
  static const VerificationMeta _cfiMeta = const VerificationMeta('cfi');
  @override
  late final GeneratedColumn<String> cfi = GeneratedColumn<String>(
      'cfi', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _audioSecMeta =
      const VerificationMeta('audioSec');
  @override
  late final GeneratedColumn<int> audioSec = GeneratedColumn<int>(
      'audio_sec', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bookId, cfi, page, audioSec, note, createdAt, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('cfi')) {
      context.handle(
          _cfiMeta, cfi.isAcceptableOrUnknown(data['cfi']!, _cfiMeta));
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    }
    if (data.containsKey('audio_sec')) {
      context.handle(_audioSecMeta,
          audioSec.isAcceptableOrUnknown(data['audio_sec']!, _audioSecMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
      cfi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cfi']),
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page']),
      audioSec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}audio_sec']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final String id;
  final String bookId;
  final String? cfi;
  final int? page;
  final int? audioSec;
  final String? note;
  final DateTime createdAt;
  final String? color;
  const Bookmark(
      {required this.id,
      required this.bookId,
      this.cfi,
      this.page,
      this.audioSec,
      this.note,
      required this.createdAt,
      this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    if (!nullToAbsent || cfi != null) {
      map['cfi'] = Variable<String>(cfi);
    }
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    if (!nullToAbsent || audioSec != null) {
      map['audio_sec'] = Variable<int>(audioSec);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      bookId: Value(bookId),
      cfi: cfi == null && nullToAbsent ? const Value.absent() : Value(cfi),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
      audioSec: audioSec == null && nullToAbsent
          ? const Value.absent()
          : Value(audioSec),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      cfi: serializer.fromJson<String?>(json['cfi']),
      page: serializer.fromJson<int?>(json['page']),
      audioSec: serializer.fromJson<int?>(json['audioSec']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      color: serializer.fromJson<String?>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'cfi': serializer.toJson<String?>(cfi),
      'page': serializer.toJson<int?>(page),
      'audioSec': serializer.toJson<int?>(audioSec),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'color': serializer.toJson<String?>(color),
    };
  }

  Bookmark copyWith(
          {String? id,
          String? bookId,
          Value<String?> cfi = const Value.absent(),
          Value<int?> page = const Value.absent(),
          Value<int?> audioSec = const Value.absent(),
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          Value<String?> color = const Value.absent()}) =>
      Bookmark(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        cfi: cfi.present ? cfi.value : this.cfi,
        page: page.present ? page.value : this.page,
        audioSec: audioSec.present ? audioSec.value : this.audioSec,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        color: color.present ? color.value : this.color,
      );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      cfi: data.cfi.present ? data.cfi.value : this.cfi,
      page: data.page.present ? data.page.value : this.page,
      audioSec: data.audioSec.present ? data.audioSec.value : this.audioSec,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('cfi: $cfi, ')
          ..write('page: $page, ')
          ..write('audioSec: $audioSec, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bookId, cfi, page, audioSec, note, createdAt, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.cfi == this.cfi &&
          other.page == this.page &&
          other.audioSec == this.audioSec &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.color == this.color);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<String?> cfi;
  final Value<int?> page;
  final Value<int?> audioSec;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<String?> color;
  final Value<int> rowid;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.cfi = const Value.absent(),
    this.page = const Value.absent(),
    this.audioSec = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksCompanion.insert({
    required String id,
    required String bookId,
    this.cfi = const Value.absent(),
    this.page = const Value.absent(),
    this.audioSec = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bookId = Value(bookId),
        createdAt = Value(createdAt);
  static Insertable<Bookmark> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<String>? cfi,
    Expression<int>? page,
    Expression<int>? audioSec,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<String>? color,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (cfi != null) 'cfi': cfi,
      if (page != null) 'page': page,
      if (audioSec != null) 'audio_sec': audioSec,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (color != null) 'color': color,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksCompanion copyWith(
      {Value<String>? id,
      Value<String>? bookId,
      Value<String?>? cfi,
      Value<int?>? page,
      Value<int?>? audioSec,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<String?>? color,
      Value<int>? rowid}) {
    return BookmarksCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      cfi: cfi ?? this.cfi,
      page: page ?? this.page,
      audioSec: audioSec ?? this.audioSec,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (cfi.present) {
      map['cfi'] = Variable<String>(cfi.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (audioSec.present) {
      map['audio_sec'] = Variable<int>(audioSec.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('cfi: $cfi, ')
          ..write('page: $page, ')
          ..write('audioSec: $audioSec, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('color: $color, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HighlightsTable extends Highlights
    with TableInfo<$HighlightsTable, Highlight> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HighlightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES books (id)'));
  static const VerificationMeta _cfiMeta = const VerificationMeta('cfi');
  @override
  late final GeneratedColumn<String> cfi = GeneratedColumn<String>(
      'cfi', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _positionFractionMeta =
      const VerificationMeta('positionFraction');
  @override
  late final GeneratedColumn<int> positionFraction = GeneratedColumn<int>(
      'position_fraction', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _rectLeftMeta =
      const VerificationMeta('rectLeft');
  @override
  late final GeneratedColumn<int> rectLeft = GeneratedColumn<int>(
      'rect_left', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _rectTopMeta =
      const VerificationMeta('rectTop');
  @override
  late final GeneratedColumn<int> rectTop = GeneratedColumn<int>(
      'rect_top', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _rectWidthMeta =
      const VerificationMeta('rectWidth');
  @override
  late final GeneratedColumn<int> rectWidth = GeneratedColumn<int>(
      'rect_width', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _rectHeightMeta =
      const VerificationMeta('rectHeight');
  @override
  late final GeneratedColumn<int> rectHeight = GeneratedColumn<int>(
      'rect_height', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _excerptMeta =
      const VerificationMeta('excerpt');
  @override
  late final GeneratedColumn<String> excerpt = GeneratedColumn<String>(
      'excerpt', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        bookId,
        cfi,
        page,
        positionFraction,
        rectLeft,
        rectTop,
        rectWidth,
        rectHeight,
        excerpt,
        note,
        color,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'highlights';
  @override
  VerificationContext validateIntegrity(Insertable<Highlight> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('cfi')) {
      context.handle(
          _cfiMeta, cfi.isAcceptableOrUnknown(data['cfi']!, _cfiMeta));
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    }
    if (data.containsKey('position_fraction')) {
      context.handle(
          _positionFractionMeta,
          positionFraction.isAcceptableOrUnknown(
              data['position_fraction']!, _positionFractionMeta));
    }
    if (data.containsKey('rect_left')) {
      context.handle(_rectLeftMeta,
          rectLeft.isAcceptableOrUnknown(data['rect_left']!, _rectLeftMeta));
    }
    if (data.containsKey('rect_top')) {
      context.handle(_rectTopMeta,
          rectTop.isAcceptableOrUnknown(data['rect_top']!, _rectTopMeta));
    }
    if (data.containsKey('rect_width')) {
      context.handle(_rectWidthMeta,
          rectWidth.isAcceptableOrUnknown(data['rect_width']!, _rectWidthMeta));
    }
    if (data.containsKey('rect_height')) {
      context.handle(
          _rectHeightMeta,
          rectHeight.isAcceptableOrUnknown(
              data['rect_height']!, _rectHeightMeta));
    }
    if (data.containsKey('excerpt')) {
      context.handle(_excerptMeta,
          excerpt.isAcceptableOrUnknown(data['excerpt']!, _excerptMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Highlight map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Highlight(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
      cfi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cfi']),
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page']),
      positionFraction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position_fraction'])!,
      rectLeft: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rect_left'])!,
      rectTop: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rect_top'])!,
      rectWidth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rect_width'])!,
      rectHeight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rect_height'])!,
      excerpt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}excerpt']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HighlightsTable createAlias(String alias) {
    return $HighlightsTable(attachedDatabase, alias);
  }
}

class Highlight extends DataClass implements Insertable<Highlight> {
  final String id;
  final String bookId;
  final String? cfi;
  final int? page;
  final int positionFraction;
  final int rectLeft;
  final int rectTop;
  final int rectWidth;
  final int rectHeight;
  final String? excerpt;
  final String? note;
  final String? color;
  final DateTime createdAt;
  const Highlight(
      {required this.id,
      required this.bookId,
      this.cfi,
      this.page,
      required this.positionFraction,
      required this.rectLeft,
      required this.rectTop,
      required this.rectWidth,
      required this.rectHeight,
      this.excerpt,
      this.note,
      this.color,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    if (!nullToAbsent || cfi != null) {
      map['cfi'] = Variable<String>(cfi);
    }
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    map['position_fraction'] = Variable<int>(positionFraction);
    map['rect_left'] = Variable<int>(rectLeft);
    map['rect_top'] = Variable<int>(rectTop);
    map['rect_width'] = Variable<int>(rectWidth);
    map['rect_height'] = Variable<int>(rectHeight);
    if (!nullToAbsent || excerpt != null) {
      map['excerpt'] = Variable<String>(excerpt);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HighlightsCompanion toCompanion(bool nullToAbsent) {
    return HighlightsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      cfi: cfi == null && nullToAbsent ? const Value.absent() : Value(cfi),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
      positionFraction: Value(positionFraction),
      rectLeft: Value(rectLeft),
      rectTop: Value(rectTop),
      rectWidth: Value(rectWidth),
      rectHeight: Value(rectHeight),
      excerpt: excerpt == null && nullToAbsent
          ? const Value.absent()
          : Value(excerpt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory Highlight.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Highlight(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      cfi: serializer.fromJson<String?>(json['cfi']),
      page: serializer.fromJson<int?>(json['page']),
      positionFraction: serializer.fromJson<int>(json['positionFraction']),
      rectLeft: serializer.fromJson<int>(json['rectLeft']),
      rectTop: serializer.fromJson<int>(json['rectTop']),
      rectWidth: serializer.fromJson<int>(json['rectWidth']),
      rectHeight: serializer.fromJson<int>(json['rectHeight']),
      excerpt: serializer.fromJson<String?>(json['excerpt']),
      note: serializer.fromJson<String?>(json['note']),
      color: serializer.fromJson<String?>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'cfi': serializer.toJson<String?>(cfi),
      'page': serializer.toJson<int?>(page),
      'positionFraction': serializer.toJson<int>(positionFraction),
      'rectLeft': serializer.toJson<int>(rectLeft),
      'rectTop': serializer.toJson<int>(rectTop),
      'rectWidth': serializer.toJson<int>(rectWidth),
      'rectHeight': serializer.toJson<int>(rectHeight),
      'excerpt': serializer.toJson<String?>(excerpt),
      'note': serializer.toJson<String?>(note),
      'color': serializer.toJson<String?>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Highlight copyWith(
          {String? id,
          String? bookId,
          Value<String?> cfi = const Value.absent(),
          Value<int?> page = const Value.absent(),
          int? positionFraction,
          int? rectLeft,
          int? rectTop,
          int? rectWidth,
          int? rectHeight,
          Value<String?> excerpt = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<String?> color = const Value.absent(),
          DateTime? createdAt}) =>
      Highlight(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        cfi: cfi.present ? cfi.value : this.cfi,
        page: page.present ? page.value : this.page,
        positionFraction: positionFraction ?? this.positionFraction,
        rectLeft: rectLeft ?? this.rectLeft,
        rectTop: rectTop ?? this.rectTop,
        rectWidth: rectWidth ?? this.rectWidth,
        rectHeight: rectHeight ?? this.rectHeight,
        excerpt: excerpt.present ? excerpt.value : this.excerpt,
        note: note.present ? note.value : this.note,
        color: color.present ? color.value : this.color,
        createdAt: createdAt ?? this.createdAt,
      );
  Highlight copyWithCompanion(HighlightsCompanion data) {
    return Highlight(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      cfi: data.cfi.present ? data.cfi.value : this.cfi,
      page: data.page.present ? data.page.value : this.page,
      positionFraction: data.positionFraction.present
          ? data.positionFraction.value
          : this.positionFraction,
      rectLeft: data.rectLeft.present ? data.rectLeft.value : this.rectLeft,
      rectTop: data.rectTop.present ? data.rectTop.value : this.rectTop,
      rectWidth: data.rectWidth.present ? data.rectWidth.value : this.rectWidth,
      rectHeight:
          data.rectHeight.present ? data.rectHeight.value : this.rectHeight,
      excerpt: data.excerpt.present ? data.excerpt.value : this.excerpt,
      note: data.note.present ? data.note.value : this.note,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Highlight(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('cfi: $cfi, ')
          ..write('page: $page, ')
          ..write('positionFraction: $positionFraction, ')
          ..write('rectLeft: $rectLeft, ')
          ..write('rectTop: $rectTop, ')
          ..write('rectWidth: $rectWidth, ')
          ..write('rectHeight: $rectHeight, ')
          ..write('excerpt: $excerpt, ')
          ..write('note: $note, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      bookId,
      cfi,
      page,
      positionFraction,
      rectLeft,
      rectTop,
      rectWidth,
      rectHeight,
      excerpt,
      note,
      color,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Highlight &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.cfi == this.cfi &&
          other.page == this.page &&
          other.positionFraction == this.positionFraction &&
          other.rectLeft == this.rectLeft &&
          other.rectTop == this.rectTop &&
          other.rectWidth == this.rectWidth &&
          other.rectHeight == this.rectHeight &&
          other.excerpt == this.excerpt &&
          other.note == this.note &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class HighlightsCompanion extends UpdateCompanion<Highlight> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<String?> cfi;
  final Value<int?> page;
  final Value<int> positionFraction;
  final Value<int> rectLeft;
  final Value<int> rectTop;
  final Value<int> rectWidth;
  final Value<int> rectHeight;
  final Value<String?> excerpt;
  final Value<String?> note;
  final Value<String?> color;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HighlightsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.cfi = const Value.absent(),
    this.page = const Value.absent(),
    this.positionFraction = const Value.absent(),
    this.rectLeft = const Value.absent(),
    this.rectTop = const Value.absent(),
    this.rectWidth = const Value.absent(),
    this.rectHeight = const Value.absent(),
    this.excerpt = const Value.absent(),
    this.note = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HighlightsCompanion.insert({
    required String id,
    required String bookId,
    this.cfi = const Value.absent(),
    this.page = const Value.absent(),
    this.positionFraction = const Value.absent(),
    this.rectLeft = const Value.absent(),
    this.rectTop = const Value.absent(),
    this.rectWidth = const Value.absent(),
    this.rectHeight = const Value.absent(),
    this.excerpt = const Value.absent(),
    this.note = const Value.absent(),
    this.color = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bookId = Value(bookId),
        createdAt = Value(createdAt);
  static Insertable<Highlight> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<String>? cfi,
    Expression<int>? page,
    Expression<int>? positionFraction,
    Expression<int>? rectLeft,
    Expression<int>? rectTop,
    Expression<int>? rectWidth,
    Expression<int>? rectHeight,
    Expression<String>? excerpt,
    Expression<String>? note,
    Expression<String>? color,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (cfi != null) 'cfi': cfi,
      if (page != null) 'page': page,
      if (positionFraction != null) 'position_fraction': positionFraction,
      if (rectLeft != null) 'rect_left': rectLeft,
      if (rectTop != null) 'rect_top': rectTop,
      if (rectWidth != null) 'rect_width': rectWidth,
      if (rectHeight != null) 'rect_height': rectHeight,
      if (excerpt != null) 'excerpt': excerpt,
      if (note != null) 'note': note,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HighlightsCompanion copyWith(
      {Value<String>? id,
      Value<String>? bookId,
      Value<String?>? cfi,
      Value<int?>? page,
      Value<int>? positionFraction,
      Value<int>? rectLeft,
      Value<int>? rectTop,
      Value<int>? rectWidth,
      Value<int>? rectHeight,
      Value<String?>? excerpt,
      Value<String?>? note,
      Value<String?>? color,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return HighlightsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      cfi: cfi ?? this.cfi,
      page: page ?? this.page,
      positionFraction: positionFraction ?? this.positionFraction,
      rectLeft: rectLeft ?? this.rectLeft,
      rectTop: rectTop ?? this.rectTop,
      rectWidth: rectWidth ?? this.rectWidth,
      rectHeight: rectHeight ?? this.rectHeight,
      excerpt: excerpt ?? this.excerpt,
      note: note ?? this.note,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (cfi.present) {
      map['cfi'] = Variable<String>(cfi.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (positionFraction.present) {
      map['position_fraction'] = Variable<int>(positionFraction.value);
    }
    if (rectLeft.present) {
      map['rect_left'] = Variable<int>(rectLeft.value);
    }
    if (rectTop.present) {
      map['rect_top'] = Variable<int>(rectTop.value);
    }
    if (rectWidth.present) {
      map['rect_width'] = Variable<int>(rectWidth.value);
    }
    if (rectHeight.present) {
      map['rect_height'] = Variable<int>(rectHeight.value);
    }
    if (excerpt.present) {
      map['excerpt'] = Variable<String>(excerpt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HighlightsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('cfi: $cfi, ')
          ..write('page: $page, ')
          ..write('positionFraction: $positionFraction, ')
          ..write('rectLeft: $rectLeft, ')
          ..write('rectTop: $rectTop, ')
          ..write('rectWidth: $rectWidth, ')
          ..write('rectHeight: $rectHeight, ')
          ..write('excerpt: $excerpt, ')
          ..write('note: $note, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $ReadingPositionsTable readingPositions =
      $ReadingPositionsTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $HighlightsTable highlights = $HighlightsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [books, readingPositions, bookmarks, highlights];
}

typedef $$BooksTableCreateCompanionBuilder = BooksCompanion Function({
  required String id,
  required String path,
  required String hash,
  required String title,
  required String author,
  Value<String?> series,
  Value<String?> genre,
  required String tags,
  required BookType type,
  Value<String?> coverPath,
  Value<int?> durationSec,
  Value<int?> pageCount,
  required DateTime addedAt,
  required DateTime lastOpenedAt,
  Value<int> rowid,
});
typedef $$BooksTableUpdateCompanionBuilder = BooksCompanion Function({
  Value<String> id,
  Value<String> path,
  Value<String> hash,
  Value<String> title,
  Value<String> author,
  Value<String?> series,
  Value<String?> genre,
  Value<String> tags,
  Value<BookType> type,
  Value<String?> coverPath,
  Value<int?> durationSec,
  Value<int?> pageCount,
  Value<DateTime> addedAt,
  Value<DateTime> lastOpenedAt,
  Value<int> rowid,
});

final class $$BooksTableReferences
    extends BaseReferences<_$AppDatabase, $BooksTable, Book> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ReadingPositionsTable, List<ReadingPosition>>
      _readingPositionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.readingPositions,
              aliasName: $_aliasNameGenerator(
                  db.books.id, db.readingPositions.bookId));

  $$ReadingPositionsTableProcessedTableManager get readingPositionsRefs {
    final manager =
        $$ReadingPositionsTableTableManager($_db, $_db.readingPositions)
            .filter((f) => f.bookId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_readingPositionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BookmarksTable, List<Bookmark>>
      _bookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.bookmarks,
          aliasName: $_aliasNameGenerator(db.books.id, db.bookmarks.bookId));

  $$BookmarksTableProcessedTableManager get bookmarksRefs {
    final manager = $$BookmarksTableTableManager($_db, $_db.bookmarks)
        .filter((f) => f.bookId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_bookmarksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$HighlightsTable, List<Highlight>>
      _highlightsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.highlights,
          aliasName: $_aliasNameGenerator(db.books.id, db.highlights.bookId));

  $$HighlightsTableProcessedTableManager get highlightsRefs {
    final manager = $$HighlightsTableTableManager($_db, $_db.highlights)
        .filter((f) => f.bookId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_highlightsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hash => $composableBuilder(
      column: $table.hash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get series => $composableBuilder(
      column: $table.series, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<BookType, BookType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get coverPath => $composableBuilder(
      column: $table.coverPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSec => $composableBuilder(
      column: $table.durationSec, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pageCount => $composableBuilder(
      column: $table.pageCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastOpenedAt => $composableBuilder(
      column: $table.lastOpenedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> readingPositionsRefs(
      Expression<bool> Function($$ReadingPositionsTableFilterComposer f) f) {
    final $$ReadingPositionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.readingPositions,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReadingPositionsTableFilterComposer(
              $db: $db,
              $table: $db.readingPositions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> bookmarksRefs(
      Expression<bool> Function($$BookmarksTableFilterComposer f) f) {
    final $$BookmarksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bookmarks,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BookmarksTableFilterComposer(
              $db: $db,
              $table: $db.bookmarks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> highlightsRefs(
      Expression<bool> Function($$HighlightsTableFilterComposer f) f) {
    final $$HighlightsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.highlights,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HighlightsTableFilterComposer(
              $db: $db,
              $table: $db.highlights,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hash => $composableBuilder(
      column: $table.hash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get series => $composableBuilder(
      column: $table.series, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverPath => $composableBuilder(
      column: $table.coverPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSec => $composableBuilder(
      column: $table.durationSec, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pageCount => $composableBuilder(
      column: $table.pageCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastOpenedAt => $composableBuilder(
      column: $table.lastOpenedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BookType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get coverPath =>
      $composableBuilder(column: $table.coverPath, builder: (column) => column);

  GeneratedColumn<int> get durationSec => $composableBuilder(
      column: $table.durationSec, builder: (column) => column);

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastOpenedAt => $composableBuilder(
      column: $table.lastOpenedAt, builder: (column) => column);

  Expression<T> readingPositionsRefs<T extends Object>(
      Expression<T> Function($$ReadingPositionsTableAnnotationComposer a) f) {
    final $$ReadingPositionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.readingPositions,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReadingPositionsTableAnnotationComposer(
              $db: $db,
              $table: $db.readingPositions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> bookmarksRefs<T extends Object>(
      Expression<T> Function($$BookmarksTableAnnotationComposer a) f) {
    final $$BookmarksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bookmarks,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BookmarksTableAnnotationComposer(
              $db: $db,
              $table: $db.bookmarks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> highlightsRefs<T extends Object>(
      Expression<T> Function($$HighlightsTableAnnotationComposer a) f) {
    final $$HighlightsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.highlights,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HighlightsTableAnnotationComposer(
              $db: $db,
              $table: $db.highlights,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BooksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BooksTable,
    Book,
    $$BooksTableFilterComposer,
    $$BooksTableOrderingComposer,
    $$BooksTableAnnotationComposer,
    $$BooksTableCreateCompanionBuilder,
    $$BooksTableUpdateCompanionBuilder,
    (Book, $$BooksTableReferences),
    Book,
    PrefetchHooks Function(
        {bool readingPositionsRefs, bool bookmarksRefs, bool highlightsRefs})> {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String> hash = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String?> series = const Value.absent(),
            Value<String?> genre = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<BookType> type = const Value.absent(),
            Value<String?> coverPath = const Value.absent(),
            Value<int?> durationSec = const Value.absent(),
            Value<int?> pageCount = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
            Value<DateTime> lastOpenedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BooksCompanion(
            id: id,
            path: path,
            hash: hash,
            title: title,
            author: author,
            series: series,
            genre: genre,
            tags: tags,
            type: type,
            coverPath: coverPath,
            durationSec: durationSec,
            pageCount: pageCount,
            addedAt: addedAt,
            lastOpenedAt: lastOpenedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String path,
            required String hash,
            required String title,
            required String author,
            Value<String?> series = const Value.absent(),
            Value<String?> genre = const Value.absent(),
            required String tags,
            required BookType type,
            Value<String?> coverPath = const Value.absent(),
            Value<int?> durationSec = const Value.absent(),
            Value<int?> pageCount = const Value.absent(),
            required DateTime addedAt,
            required DateTime lastOpenedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BooksCompanion.insert(
            id: id,
            path: path,
            hash: hash,
            title: title,
            author: author,
            series: series,
            genre: genre,
            tags: tags,
            type: type,
            coverPath: coverPath,
            durationSec: durationSec,
            pageCount: pageCount,
            addedAt: addedAt,
            lastOpenedAt: lastOpenedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BooksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {readingPositionsRefs = false,
              bookmarksRefs = false,
              highlightsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (readingPositionsRefs) db.readingPositions,
                if (bookmarksRefs) db.bookmarks,
                if (highlightsRefs) db.highlights
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (readingPositionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$BooksTableReferences
                            ._readingPositionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BooksTableReferences(db, table, p0)
                                .readingPositionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items),
                  if (bookmarksRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BooksTableReferences._bookmarksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BooksTableReferences(db, table, p0).bookmarksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items),
                  if (highlightsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BooksTableReferences._highlightsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BooksTableReferences(db, table, p0)
                                .highlightsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BooksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BooksTable,
    Book,
    $$BooksTableFilterComposer,
    $$BooksTableOrderingComposer,
    $$BooksTableAnnotationComposer,
    $$BooksTableCreateCompanionBuilder,
    $$BooksTableUpdateCompanionBuilder,
    (Book, $$BooksTableReferences),
    Book,
    PrefetchHooks Function(
        {bool readingPositionsRefs, bool bookmarksRefs, bool highlightsRefs})>;
typedef $$ReadingPositionsTableCreateCompanionBuilder
    = ReadingPositionsCompanion Function({
  required String bookId,
  Value<String?> cfi,
  Value<int?> page,
  Value<int?> audioSec,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ReadingPositionsTableUpdateCompanionBuilder
    = ReadingPositionsCompanion Function({
  Value<String> bookId,
  Value<String?> cfi,
  Value<int?> page,
  Value<int?> audioSec,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$ReadingPositionsTableReferences extends BaseReferences<
    _$AppDatabase, $ReadingPositionsTable, ReadingPosition> {
  $$ReadingPositionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
      $_aliasNameGenerator(db.readingPositions.bookId, db.books.id));

  $$BooksTableProcessedTableManager get bookId {
    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.id($_item.bookId));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ReadingPositionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingPositionsTable> {
  $$ReadingPositionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cfi => $composableBuilder(
      column: $table.cfi, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get page => $composableBuilder(
      column: $table.page, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get audioSec => $composableBuilder(
      column: $table.audioSec, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReadingPositionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingPositionsTable> {
  $$ReadingPositionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cfi => $composableBuilder(
      column: $table.cfi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get page => $composableBuilder(
      column: $table.page, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get audioSec => $composableBuilder(
      column: $table.audioSec, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableOrderingComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReadingPositionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingPositionsTable> {
  $$ReadingPositionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cfi =>
      $composableBuilder(column: $table.cfi, builder: (column) => column);

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);

  GeneratedColumn<int> get audioSec =>
      $composableBuilder(column: $table.audioSec, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReadingPositionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReadingPositionsTable,
    ReadingPosition,
    $$ReadingPositionsTableFilterComposer,
    $$ReadingPositionsTableOrderingComposer,
    $$ReadingPositionsTableAnnotationComposer,
    $$ReadingPositionsTableCreateCompanionBuilder,
    $$ReadingPositionsTableUpdateCompanionBuilder,
    (ReadingPosition, $$ReadingPositionsTableReferences),
    ReadingPosition,
    PrefetchHooks Function({bool bookId})> {
  $$ReadingPositionsTableTableManager(
      _$AppDatabase db, $ReadingPositionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingPositionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingPositionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingPositionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> bookId = const Value.absent(),
            Value<String?> cfi = const Value.absent(),
            Value<int?> page = const Value.absent(),
            Value<int?> audioSec = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReadingPositionsCompanion(
            bookId: bookId,
            cfi: cfi,
            page: page,
            audioSec: audioSec,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String bookId,
            Value<String?> cfi = const Value.absent(),
            Value<int?> page = const Value.absent(),
            Value<int?> audioSec = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ReadingPositionsCompanion.insert(
            bookId: bookId,
            cfi: cfi,
            page: page,
            audioSec: audioSec,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ReadingPositionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable:
                        $$ReadingPositionsTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$ReadingPositionsTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ReadingPositionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReadingPositionsTable,
    ReadingPosition,
    $$ReadingPositionsTableFilterComposer,
    $$ReadingPositionsTableOrderingComposer,
    $$ReadingPositionsTableAnnotationComposer,
    $$ReadingPositionsTableCreateCompanionBuilder,
    $$ReadingPositionsTableUpdateCompanionBuilder,
    (ReadingPosition, $$ReadingPositionsTableReferences),
    ReadingPosition,
    PrefetchHooks Function({bool bookId})>;
typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  required String id,
  required String bookId,
  Value<String?> cfi,
  Value<int?> page,
  Value<int?> audioSec,
  Value<String?> note,
  required DateTime createdAt,
  Value<String?> color,
  Value<int> rowid,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<String> id,
  Value<String> bookId,
  Value<String?> cfi,
  Value<int?> page,
  Value<int?> audioSec,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<String?> color,
  Value<int> rowid,
});

final class $$BookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark> {
  $$BookmarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books
      .createAlias($_aliasNameGenerator(db.bookmarks.bookId, db.books.id));

  $$BooksTableProcessedTableManager get bookId {
    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.id($_item.bookId));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cfi => $composableBuilder(
      column: $table.cfi, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get page => $composableBuilder(
      column: $table.page, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get audioSec => $composableBuilder(
      column: $table.audioSec, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cfi => $composableBuilder(
      column: $table.cfi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get page => $composableBuilder(
      column: $table.page, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get audioSec => $composableBuilder(
      column: $table.audioSec, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableOrderingComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cfi =>
      $composableBuilder(column: $table.cfi, builder: (column) => column);

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);

  GeneratedColumn<int> get audioSec =>
      $composableBuilder(column: $table.audioSec, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BookmarksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, $$BookmarksTableReferences),
    Bookmark,
    PrefetchHooks Function({bool bookId})> {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bookId = const Value.absent(),
            Value<String?> cfi = const Value.absent(),
            Value<int?> page = const Value.absent(),
            Value<int?> audioSec = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BookmarksCompanion(
            id: id,
            bookId: bookId,
            cfi: cfi,
            page: page,
            audioSec: audioSec,
            note: note,
            createdAt: createdAt,
            color: color,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bookId,
            Value<String?> cfi = const Value.absent(),
            Value<int?> page = const Value.absent(),
            Value<int?> audioSec = const Value.absent(),
            Value<String?> note = const Value.absent(),
            required DateTime createdAt,
            Value<String?> color = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BookmarksCompanion.insert(
            id: id,
            bookId: bookId,
            cfi: cfi,
            page: page,
            audioSec: audioSec,
            note: note,
            createdAt: createdAt,
            color: color,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BookmarksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable:
                        $$BookmarksTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$BookmarksTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BookmarksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, $$BookmarksTableReferences),
    Bookmark,
    PrefetchHooks Function({bool bookId})>;
typedef $$HighlightsTableCreateCompanionBuilder = HighlightsCompanion Function({
  required String id,
  required String bookId,
  Value<String?> cfi,
  Value<int?> page,
  Value<int> positionFraction,
  Value<int> rectLeft,
  Value<int> rectTop,
  Value<int> rectWidth,
  Value<int> rectHeight,
  Value<String?> excerpt,
  Value<String?> note,
  Value<String?> color,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$HighlightsTableUpdateCompanionBuilder = HighlightsCompanion Function({
  Value<String> id,
  Value<String> bookId,
  Value<String?> cfi,
  Value<int?> page,
  Value<int> positionFraction,
  Value<int> rectLeft,
  Value<int> rectTop,
  Value<int> rectWidth,
  Value<int> rectHeight,
  Value<String?> excerpt,
  Value<String?> note,
  Value<String?> color,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$HighlightsTableReferences
    extends BaseReferences<_$AppDatabase, $HighlightsTable, Highlight> {
  $$HighlightsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books
      .createAlias($_aliasNameGenerator(db.highlights.bookId, db.books.id));

  $$BooksTableProcessedTableManager get bookId {
    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.id($_item.bookId));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HighlightsTableFilterComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cfi => $composableBuilder(
      column: $table.cfi, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get page => $composableBuilder(
      column: $table.page, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get positionFraction => $composableBuilder(
      column: $table.positionFraction,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rectLeft => $composableBuilder(
      column: $table.rectLeft, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rectTop => $composableBuilder(
      column: $table.rectTop, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rectWidth => $composableBuilder(
      column: $table.rectWidth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rectHeight => $composableBuilder(
      column: $table.rectHeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get excerpt => $composableBuilder(
      column: $table.excerpt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HighlightsTableOrderingComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cfi => $composableBuilder(
      column: $table.cfi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get page => $composableBuilder(
      column: $table.page, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get positionFraction => $composableBuilder(
      column: $table.positionFraction,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rectLeft => $composableBuilder(
      column: $table.rectLeft, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rectTop => $composableBuilder(
      column: $table.rectTop, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rectWidth => $composableBuilder(
      column: $table.rectWidth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rectHeight => $composableBuilder(
      column: $table.rectHeight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get excerpt => $composableBuilder(
      column: $table.excerpt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableOrderingComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HighlightsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cfi =>
      $composableBuilder(column: $table.cfi, builder: (column) => column);

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);

  GeneratedColumn<int> get positionFraction => $composableBuilder(
      column: $table.positionFraction, builder: (column) => column);

  GeneratedColumn<int> get rectLeft =>
      $composableBuilder(column: $table.rectLeft, builder: (column) => column);

  GeneratedColumn<int> get rectTop =>
      $composableBuilder(column: $table.rectTop, builder: (column) => column);

  GeneratedColumn<int> get rectWidth =>
      $composableBuilder(column: $table.rectWidth, builder: (column) => column);

  GeneratedColumn<int> get rectHeight => $composableBuilder(
      column: $table.rectHeight, builder: (column) => column);

  GeneratedColumn<String> get excerpt =>
      $composableBuilder(column: $table.excerpt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HighlightsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HighlightsTable,
    Highlight,
    $$HighlightsTableFilterComposer,
    $$HighlightsTableOrderingComposer,
    $$HighlightsTableAnnotationComposer,
    $$HighlightsTableCreateCompanionBuilder,
    $$HighlightsTableUpdateCompanionBuilder,
    (Highlight, $$HighlightsTableReferences),
    Highlight,
    PrefetchHooks Function({bool bookId})> {
  $$HighlightsTableTableManager(_$AppDatabase db, $HighlightsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HighlightsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HighlightsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HighlightsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bookId = const Value.absent(),
            Value<String?> cfi = const Value.absent(),
            Value<int?> page = const Value.absent(),
            Value<int> positionFraction = const Value.absent(),
            Value<int> rectLeft = const Value.absent(),
            Value<int> rectTop = const Value.absent(),
            Value<int> rectWidth = const Value.absent(),
            Value<int> rectHeight = const Value.absent(),
            Value<String?> excerpt = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HighlightsCompanion(
            id: id,
            bookId: bookId,
            cfi: cfi,
            page: page,
            positionFraction: positionFraction,
            rectLeft: rectLeft,
            rectTop: rectTop,
            rectWidth: rectWidth,
            rectHeight: rectHeight,
            excerpt: excerpt,
            note: note,
            color: color,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bookId,
            Value<String?> cfi = const Value.absent(),
            Value<int?> page = const Value.absent(),
            Value<int> positionFraction = const Value.absent(),
            Value<int> rectLeft = const Value.absent(),
            Value<int> rectTop = const Value.absent(),
            Value<int> rectWidth = const Value.absent(),
            Value<int> rectHeight = const Value.absent(),
            Value<String?> excerpt = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> color = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              HighlightsCompanion.insert(
            id: id,
            bookId: bookId,
            cfi: cfi,
            page: page,
            positionFraction: positionFraction,
            rectLeft: rectLeft,
            rectTop: rectTop,
            rectWidth: rectWidth,
            rectHeight: rectHeight,
            excerpt: excerpt,
            note: note,
            color: color,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HighlightsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable:
                        $$HighlightsTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$HighlightsTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$HighlightsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HighlightsTable,
    Highlight,
    $$HighlightsTableFilterComposer,
    $$HighlightsTableOrderingComposer,
    $$HighlightsTableAnnotationComposer,
    $$HighlightsTableCreateCompanionBuilder,
    $$HighlightsTableUpdateCompanionBuilder,
    (Highlight, $$HighlightsTableReferences),
    Highlight,
    PrefetchHooks Function({bool bookId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$ReadingPositionsTableTableManager get readingPositions =>
      $$ReadingPositionsTableTableManager(_db, _db.readingPositions);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$HighlightsTableTableManager get highlights =>
      $$HighlightsTableTableManager(_db, _db.highlights);
}
