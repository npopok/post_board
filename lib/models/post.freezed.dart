// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Duration get createdAgo => throw _privateConstructorUsedError;
  String? get createdBy =>
      throw _privateConstructorUsedError; // TODO: Make it non-nullable after removing post scrapper
  String get author => throw _privateConstructorUsedError;
  Gender get gender => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  City get city => throw _privateConstructorUsedError;
  Category get category => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @ContactConverter()
  Contact get contact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      Duration createdAgo,
      String? createdBy,
      String author,
      Gender gender,
      int age,
      City city,
      Category category,
      String text,
      @ContactConverter() Contact contact});

  $CityCopyWith<$Res> get city;
  $ContactCopyWith<$Res> get contact;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? createdAgo = null,
    Object? createdBy = freezed,
    Object? author = null,
    Object? gender = null,
    Object? age = null,
    Object? city = null,
    Object? category = null,
    Object? text = null,
    Object? contact = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAgo: null == createdAgo
          ? _value.createdAgo
          : createdAgo // ignore: cast_nullable_to_non_nullable
              as Duration,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as City,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CityCopyWith<$Res> get city {
    return $CityCopyWith<$Res>(_value.city, (value) {
      return _then(_value.copyWith(city: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ContactCopyWith<$Res> get contact {
    return $ContactCopyWith<$Res>(_value.contact, (value) {
      return _then(_value.copyWith(contact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      Duration createdAgo,
      String? createdBy,
      String author,
      Gender gender,
      int age,
      City city,
      Category category,
      String text,
      @ContactConverter() Contact contact});

  @override
  $CityCopyWith<$Res> get city;
  @override
  $ContactCopyWith<$Res> get contact;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? createdAgo = null,
    Object? createdBy = freezed,
    Object? author = null,
    Object? gender = null,
    Object? age = null,
    Object? city = null,
    Object? category = null,
    Object? text = null,
    Object? contact = null,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAgo: null == createdAgo
          ? _value.createdAgo
          : createdAgo // ignore: cast_nullable_to_non_nullable
              as Duration,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as City,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  const _$PostImpl(
      {required this.id,
      required this.createdAt,
      required this.createdAgo,
      required this.createdBy,
      required this.author,
      required this.gender,
      required this.age,
      required this.city,
      required this.category,
      required this.text,
      @ContactConverter() required this.contact});

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final Duration createdAgo;
  @override
  final String? createdBy;
// TODO: Make it non-nullable after removing post scrapper
  @override
  final String author;
  @override
  final Gender gender;
  @override
  final int age;
  @override
  final City city;
  @override
  final Category category;
  @override
  final String text;
  @override
  @ContactConverter()
  final Contact contact;

  @override
  String toString() {
    return 'Post(id: $id, createdAt: $createdAt, createdAgo: $createdAgo, createdBy: $createdBy, author: $author, gender: $gender, age: $age, city: $city, category: $category, text: $text, contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdAgo, createdAgo) ||
                other.createdAgo == createdAgo) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, createdAgo,
      createdBy, author, gender, age, city, category, text, contact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
      {required final int id,
      required final DateTime createdAt,
      required final Duration createdAgo,
      required final String? createdBy,
      required final String author,
      required final Gender gender,
      required final int age,
      required final City city,
      required final Category category,
      required final String text,
      @ContactConverter() required final Contact contact}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  Duration get createdAgo;
  @override
  String? get createdBy;
  @override // TODO: Make it non-nullable after removing post scrapper
  String get author;
  @override
  Gender get gender;
  @override
  int get age;
  @override
  City get city;
  @override
  Category get category;
  @override
  String get text;
  @override
  @ContactConverter()
  Contact get contact;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
