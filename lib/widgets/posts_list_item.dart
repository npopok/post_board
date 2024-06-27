import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_board/common/common.dart';

import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/location_state.dart';
import 'package:post_board/widgets/widgets.dart';

enum PostAction {
  //writeChat,
  writeEmail,
  writeWhatsapp,
  writeTelegram,
  copyContact,
  copyText,
}

class PostListItem extends ConsumerWidget {
  final Post post;

  const PostListItem({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationStateProvider);

    return ListTile(
      key: ValueKey(post),
      title: Column(
        children: [
          _buildNameAgeTime(context),
          FormLayout.tinySpacer,
          _buildCityDistance(context, location),
          FormLayout.smallSpacer,
        ],
      ),
      subtitle: Text(post.text),
      onTap: () => _showContactMenu(context, post),
    );
  }

  Widget _buildNameAgeTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${post.author}, ${post.age}',
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
        context.textSmall(Duration(seconds: post.createdAgo).formatTimeAgo()),
      ],
      //   ),
    );
  }

  Widget _buildCityDistance(BuildContext context, Location location) {
    final distance = post.location.distanceFrom(location);
    return Row(
      children: [
        context.textSmall(post.city.name),
        if (distance > 0) ...[
          FormLayout.smallSpacer,
          context.textSmall('•'),
          FormLayout.smallSpacer,
          context.textSmall(DistanceFormatter.format(distance)),
        ],
      ],
    );
  }

  void _showContactMenu(BuildContext context, Post post) async {
    final contact = post.contact;
    final actions = _getPostActions(contact.type);
    final entries = actions.entries.toList();

    final action = await showModalBottomSheet<PostAction>(
      isScrollControlled: true,
      context: context,
      builder: (context) => ActionDialog(
        itemCount: actions.length,
        itemBuilder: (index) => ActionItem(
          value: entries[index].key,
          text: entries[index].value,
          icon: _popupMenuIcon(contact.type, entries[index].key),
        ),
      ),
    );
    if (action != null) {
      final result = await _performPostAction(action, post);
      if (!result) {
        showSnackBar('PostDetails.ActionFailed'.tr());
      }
    }
  }

  Widget _popupMenuIcon(ContactType type, PostAction action) {
    return switch (action) {
      PostAction.writeEmail => ContactIcon(type: type),
      PostAction.writeWhatsapp => CommonIcons.whatsapp,
      PostAction.writeTelegram => ContactIcon(type: type),
      PostAction.copyContact => const Icon(Icons.contact_page_outlined),
      PostAction.copyText => const Icon(Icons.copy_outlined),
    };
  }

  Map<PostAction, String> _getPostActions(ContactType type) {
    final Map<PostAction, String> actions = {};
    if (type == ContactType.email) {
      actions[PostAction.writeEmail] = 'PostDetails.WriteEmail'.tr();
    } else if (type == ContactType.phone) {
      actions[PostAction.writeWhatsapp] = 'PostDetails.WriteWhatsapp'.tr();
    } else if (type == ContactType.telegram) {
      actions[PostAction.writeTelegram] = 'PostDetails.WriteTelegram'.tr();
    }
    actions[PostAction.copyContact] = 'PostDetails.CopyContact'.tr();
    actions[PostAction.copyText] = 'PostDetails.CopyText'.tr();
    return actions;
  }

  Future<bool> _performPostAction(PostAction action, Post post) async {
    logEvent(AnalyticsEvent.postsAction, {AnalyticsParameter.postAction: action});

    final contact = post.contact;
    switch (action) {
      case PostAction.writeEmail:
        return LaunchHelper.openEmail(contact.details);
      case PostAction.writeWhatsapp:
        return LaunchHelper.openWhatsapp(contact.details);
      case PostAction.writeTelegram:
        return LaunchHelper.openTelegram(contact.details);
      case PostAction.copyContact:
        await Clipboard.setData(ClipboardData(text: contact.details));
        return true;
      case PostAction.copyText:
        await Clipboard.setData(ClipboardData(text: post.text));
        return true;
    }
  }
}
