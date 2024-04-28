// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsStateHash() => r'48a8b6ebde2b1e10d874ab520d8717a7e655a109';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PostsState
    extends BuildlessAutoDisposeAsyncNotifier<List<Post>> {
  late final Category category;

  FutureOr<List<Post>> build(
    Category category,
  );
}

/// See also [PostsState].
@ProviderFor(PostsState)
const postsStateProvider = PostsStateFamily();

/// See also [PostsState].
class PostsStateFamily extends Family<AsyncValue<List<Post>>> {
  /// See also [PostsState].
  const PostsStateFamily();

  /// See also [PostsState].
  PostsStateProvider call(
    Category category,
  ) {
    return PostsStateProvider(
      category,
    );
  }

  @override
  PostsStateProvider getProviderOverride(
    covariant PostsStateProvider provider,
  ) {
    return call(
      provider.category,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postsStateProvider';
}

/// See also [PostsState].
class PostsStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PostsState, List<Post>> {
  /// See also [PostsState].
  PostsStateProvider(
    Category category,
  ) : this._internal(
          () => PostsState()..category = category,
          from: postsStateProvider,
          name: r'postsStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postsStateHash,
          dependencies: PostsStateFamily._dependencies,
          allTransitiveDependencies:
              PostsStateFamily._allTransitiveDependencies,
          category: category,
        );

  PostsStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final Category category;

  @override
  FutureOr<List<Post>> runNotifierBuild(
    covariant PostsState notifier,
  ) {
    return notifier.build(
      category,
    );
  }

  @override
  Override overrideWith(PostsState Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostsStateProvider._internal(
        () => create()..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PostsState, List<Post>>
      createElement() {
    return _PostsStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostsStateProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostsStateRef on AutoDisposeAsyncNotifierProviderRef<List<Post>> {
  /// The parameter `category` of this provider.
  Category get category;
}

class _PostsStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostsState, List<Post>>
    with PostsStateRef {
  _PostsStateProviderElement(super.provider);

  @override
  Category get category => (origin as PostsStateProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
