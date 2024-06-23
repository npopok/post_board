import 'package:flutter/material.dart';
import 'package:post_board/models/models.dart';

class FieldConstraints {
  static const nameMaxLength = 30;
  static const ageMinValue = 18;
  static const ageMaxValue = 80;
  static const postMinLength = 10;
  static const postMaxLength = 500;
  static const contactMaxLength = 30;
  static const distanceMinValue = 5;
  static const distanceMaxValue = 200;
}

class DefaultSettings {
  static const darkTheme = true;
  static const showDistance = true;
  static const category = Category.sex;
  static const distance = 50;
}

class RegionalSettings {
  static const countryCode = '+7';
  static const countryCodeAlt = '8';
}

class RepositorySettings {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

  static const setupLocalKey = 'setup';
  static const profileLocalKey = 'profile';
  static const citiesLocalKey = 'cities';
  static const filtersLocalKey = 'filters';
  static const settingsLocalKey = 'settings';

  static const functionAddPost = 'add_post';
  static const functionGetPosts = 'get_posts';

  static const profilesRemoteTable = 'profiles';
  static const filtersRemoteTable = 'filters';
  static const citiesRemoteTable = 'cities';

  static const postsQuotaExceeded = 'posts-quota-exceeded';
  static const postsCacheDuration = Duration(minutes: 15);
  static const postsMaxId = (1 << 63) - 1;
  static const postsPageSize = 20;

  static const citiesCacheDuration = Duration(days: 10000);
}

class LocationSettings {
  static const emptyLocation = Location(latitude: 0.0, longitude: 0.0);
  static const listenerDistance = 1000;
}

class FormLayout {
  static const contentPadding = EdgeInsets.all(24);
  static const tinySpacer = SizedBox.square(dimension: 2);
  static const smallSpacer = SizedBox.square(dimension: 4);
  static const defaultSpacer = SizedBox.square(dimension: 8);
  static const textSpacer = SizedBox.square(dimension: 12);
  static const inputSpacer = SizedBox.square(dimension: 20);
}

class DialogPaddings {
  static const iOSDialog = EdgeInsets.only(top: 4, bottom: 32);
  static const androidDialog = EdgeInsets.only(top: 4, bottom: 8);

  static const dialogTitle = EdgeInsets.only(top: 16);
  static const defaultContent = EdgeInsets.symmetric(vertical: 8);

  static const actionContent = EdgeInsets.symmetric(vertical: 4);
  static const inputContent = EdgeInsets.symmetric(horizontal: 24, vertical: 20);
  static const promptContent = EdgeInsets.symmetric(horizontal: 32, vertical: 24);
  static const sliderContent = EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  static const valueContent = EdgeInsets.symmetric(vertical: 4);
  static const valueTile = EdgeInsets.symmetric(horizontal: 24);

  static const locationContent = EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 8);
  static const locationText = EdgeInsets.all(16);
}

class CommonIcons {
  static const whatsapp = ImageIcon(AssetImage('assets/icons/whatsapp.png'));
  static const telegram = ImageIcon(AssetImage('assets/icons/telegram.png'));
}
