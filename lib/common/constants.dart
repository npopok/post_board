import 'package:flutter/material.dart';

class FieldSettings {
  static const nameMaxLength = 30;
  static const postMinLength = 10;
  static const postMaxLength = 500;
  static const contactMaxLength = 30;
  static const ageMinValue = 18;
  static const ageMaxValue = 80;
}

class RepositorySettings {
  static const profileLocalKey = 'profile';
  static const citiesLocalKey = 'cities';
  static const filtersLocalKey = 'filters';
  static const settingsLocalKey = 'settings';

  static const postsRemoteTable = 'posts';
  static const postsQuotaExceeded = 'posts-quota-exceeded';
  static const postsCacheDuration = Duration(minutes: 5);
  static const postMaxCount = 200;
  static const citiesRemoteTable = 'cities';
  static const citiesCacheDuration = Duration(days: 10000);
}

class FormSettings {
  static const contentPadding = EdgeInsets.all(24);
  static const defaultSpacer = SizedBox(height: 8);
  static const textSpacer = SizedBox(height: 12);
  static const inputSpacer = SizedBox(height: 20);
}

class DialogPaddings {
  static const iOSDialog = EdgeInsets.only(top: 8, bottom: 32);
  static const androidDialog = EdgeInsets.only(top: 8, bottom: 8);
  static const dialogTitle = EdgeInsets.only(top: 12);
  static const defaultContent = EdgeInsets.symmetric(vertical: 8);
  static const inputContent = EdgeInsets.all(24);
  static const promptContent = EdgeInsets.symmetric(vertical: 24);
  static const sliderContent = EdgeInsets.symmetric(horizontal: 8, vertical: 8);
  static const locationContent = EdgeInsets.all(24);
  static const valueTile = EdgeInsets.symmetric(horizontal: 24);
}
