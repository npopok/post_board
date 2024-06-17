import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post_board/common/common.dart';

import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/widgets/widgets.dart';

enum PostAction {
  //writeChat,
  writeEmail,
  writeWhatsapp,
  writeTelegram,
  copyContact,
  copyText,
}

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(post),
      title: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    post.author,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
                const Text(', '),
                Text(post.age.toString()),
              ],
            ),
          ),
          FormLayout.textSpacer,
          Text(
            post.createdAgo.formatTimeAgo(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Text(post.text),
      onTap: () => _showContactMenu(context, post),
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
