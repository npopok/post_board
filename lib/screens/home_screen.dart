import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      key: UniqueKey(),
      routes: const [
        PostsRoute(),
        PostsRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: (index) async {
          if (index == 1) {
            if (ref.read(profileStateProvider).isComplete) {
              await _showSubmitDialog(context);
            } else {
              await _showProfileWarning(context, tabsRouter);
            }
          } else {
            tabsRouter.setActiveIndex(index);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_outlined),
            label: 'HomeScreen.Search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_circle_outline),
            label: 'HomeScreen.Create'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_outlined),
            label: 'HomeScreen.Profile'.tr(),
          ),
        ],
      ),
    );
  }

  Future<void> _showProfileWarning(BuildContext context, TabsRouter tabsRouter) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      builder: (_) => PromptDialog(text: 'HomeScreen.Warning'.tr()),
    );
    if (result == true) {
      tabsRouter.setActiveIndex(2);
    }
  }

  Future<void> _showSubmitDialog(BuildContext context) async {
    final data = await showModalBottomSheet<(Category, String, bool)>(
      isScrollControlled: true,
      context: context,
      builder: (_) => SubmitDialog(
        title: 'HomeScreen.Post'.tr(),
        buttonTitle: 'Button.Submit'.tr(),
      ),
    );
    if (data != null) {
      try {
        final settings = ref.read(settingsStateProvider);
        final location =
            settings.showDistance ? locationLister.location : LocationSettings.emptyLocation;
        await _submitPost(data.$1, data.$2, location);
      } on LocationException catch (e) {
        showSnackBar(e.toString());
      }
    }
  }

  Future<void> _submitPost(Category category, String text, Location location) async {
    logEvent(AnalyticsEvent.postsSubmit);

    try {
      final profile = ref.read(profileStateProvider);
      final post = Post.create(profile, category, text, profile.contact, location);

      await remoteRepository.savePost(post);
      ref.read(filtersStateProvider.notifier).category = category;
      ref.invalidate(postsStateProvider);

      showSnackBar('SubmitScreen.SubmitSuccess'.tr());
      if (mounted) context.navigateTo(const PostsRoute());
    } catch (e) {
      if (e is PostgrestException && e.message == RepositorySettings.postsQuotaExceeded) {
        showSnackBar('SubmitScreen.QuotaError'.tr(), true);
      } else {
        showSnackBar('SubmitScreen.ServerError'.tr(), true);
      }
    }
  }
}
