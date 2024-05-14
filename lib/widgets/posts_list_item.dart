import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';

enum PostAction {
  //writeChat,
  writeEmail,
  writeWhatsApp,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${post.author}, ${post.age}'),
          Text(
            post.createdAt!.formatTimeSinceNow(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Text(post.text),
      onTap: () => _showContactMenu(context, post),
    );
  }

  void _showContactMenu(BuildContext context, Post post) {
    final contact = Contact.parse(post.contact);
    final actions = _getPostActions(contact.type);

    showModalBottomSheet<PostAction>(
      isScrollControlled: true,
      context: context,
      builder: (context) => ActionDialog(
        actions: actions,
      ),
    ).then(
      (value) async {
        if (value != null && !(await _performPostAction(value, post))) {
          showSnackBar('PostDetails.ActionFailed'.tr());
        }
      },
    );
  }

  Map<PostAction, String> _getPostActions(ContactType type) {
    final Map<PostAction, String> actions = {};
    if (type == ContactType.email) {
      actions[PostAction.writeEmail] = 'PostDetails.WriteEmail'.tr();
    } else if (type == ContactType.phone) {
      actions[PostAction.writeWhatsApp] = 'PostDetails.WriteWhatsApp'.tr();
    } else if (type == ContactType.telegram) {
      actions[PostAction.writeTelegram] = 'PostDetails.WriteTelegram'.tr();
    }
    actions[PostAction.copyContact] = 'PostDetails.CopyContact'.tr();
    actions[PostAction.copyText] = 'PostDetails.CopyText'.tr();
    return actions;
  }

  Future<bool> _performPostAction(PostAction action, Post post) async {
    final contact = Contact.parse(post.contact);
    switch (action) {
      case PostAction.writeEmail:
        return LaunchHelper.openEmail(contact.details);
      case PostAction.writeWhatsApp:
        return LaunchHelper.openWhatsApp(contact.details);
      case PostAction.writeTelegram:
        return LaunchHelper.openTelegram(contact.details);
      case PostAction.copyContact:
        await Clipboard.setData(ClipboardData(text: post.contact));
        return true;
      case PostAction.copyText:
        await Clipboard.setData(ClipboardData(text: post.text));
        return true;
    }
  }
}
