import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final errorText = ValueNotifier<String>('');
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
        padding: kTextFormPadding,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTextFields(context),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownField<Category>(
          values: Category.values,
          initialValue: null,
          hintText: 'SubmitScreen.CategoryHint'.tr(),
          errorText: 'SubmitScreen.CategoryEmpty'.tr(),
          textBuilder: (value) => value.toString().tr(),
          validator: ValueExistsValidator(
            emptyMessage: 'SubmitScreen.CategoryEmpty'.tr(),
          ).validate,
          onSaved: (value) => category = value!,
        ),
        kTextFormSpacer,
        TextFormField(
          maxLines: 5,
          maxLength: kPostMaxLength,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: 'SubmitScreen.TextHint'.tr(),
            counterText: '',
          ),
          validator: TextLengthValidator(
            emptyMessage: 'SubmitScreen.TextEmpty'.tr(),
            minLength: kPostMinLength,
            minMessage: 'SubmitScreen.TextShort'.tr(),
          ).validate,
          onSaved: (value) => text = value!,
        ),
        kTextFormSpacer,
        TextFormField(
          maxLength: kContactMaxLength,
          decoration: InputDecoration(
            hintText: 'SubmitScreen.ContactHint'.tr(),
            counterText: '',
          ),
          validator: TextLengthValidator(
            emptyMessage: 'SubmitScreen.ContactEmpty'.tr(),
          ).validate,
          onSaved: (value) => contact = value!,
        ),
        kTextFormDoubleSpacer,
        ValueListenableBuilder(
          valueListenable: errorText,
          builder: (_, value, __) => Text(
            value,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: FilledButton(
        onPressed: () => _submitPostHandler(ref.read(profileStateProvider)),
        child: Text('SubmitScreen.SubmitButton'.tr()),
      ),
    );
  }

  void _submitPostHandler(Profile profile) async {
    FocusManager.instance.primaryFocus?.unfocus();
    errorText.value = '';

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      formKey.currentState!.reset();

      try {
        final post = Post.create(profile, category, text, contact);
        await remoteRepository.savePost(post);

        final filter = ref.read(filtersStateProvider);
        ref.invalidate(postsStateProvider(filter.copyWith(category: category)));

        showSnackBar('SubmitScreen.SubmitSuccess'.tr());
        if (mounted) context.navigateTo(const PostsRoute());
      } catch (e) {
        if (e is PostgrestException && e.message == kPostsQuotaExceeded) {
          errorText.value = 'SubmitScreen.QuotaError'.tr();
        } else {
          errorText.value = 'SubmitScreen.ServerError'.tr();
        }
      }
    }
  }
}
