import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/widgets/widgets.dart';

@RoutePage()
class SubmitScreen extends ConsumerStatefulWidget {
  const SubmitScreen({super.key});

  @override
  ConsumerState<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends ConsumerState<SubmitScreen> {
  final formKey = GlobalKey<FormState>();
  late Category category;
  late String text;
  late String contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SubmitScreen.Title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DropdownField<Category>(
                values: Category.values,
                initialValue: null,
                hintText: 'SubmitScreen.CategoryHint'.tr(),
                errorText: 'SubmitScreen.CategoryEmpty'.tr(),
                textBuilder: (value) => value.toString().tr(),
                onSaved: (value) => category = value!,
              ),
              const SizedBox(height: 24),
              TextFormField(
                maxLines: 3,
                maxLength: kMaxPostLength,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'SubmitScreen.TextHint'.tr(),
                  counterText: '',
                ),
                validator: _validateText,
                onSaved: (value) => text = value!,
              ),
              const SizedBox(height: 24),
              TextFormField(
                maxLength: kMaxContactLength,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'SubmitScreen.ContactHint'.tr(),
                  counterText: '',
                ),
                onSaved: (value) => contact = value!,
              ),
              const SizedBox(height: 48),
              FilledButton(
                onPressed: () => _submitPostHandler(ref.read(profileStateProvider)),
                child: Text('SubmitScreen.SubmitButton'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateText(String? value) {
    if (value?.isEmpty == true) {
      return 'SubmitScreen.TextEmpty'.tr();
    } else if (value!.length < kMinPostLength) {
      return 'SubmitScreen.TextShort'.tr();
    }
    return null;
  }

  void _submitPostHandler(Profile profile) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      formKey.currentState!.reset();
      FocusManager.instance.primaryFocus?.unfocus();

      try {
        getIt<CloudRepository>().savePost(Post.create(profile, category, text, contact));
        ref.invalidate(postsStateProvider(category));

        showSnackBar('SubmitScreen.Success'.tr());
        if (mounted) context.navigateTo(const PostsRoute());
      } catch (_) {
        showSnackBar('SubmitScreen.Error'.tr());
      }
    }
  }
}
