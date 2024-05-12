import 'package:flutter/material.dart';

const kNameMaxLength = 30;
const kPostMinLength = 10;
const kPostMaxLength = 500;
const kPostMaxCount = 200;
const kContactMaxLength = 30;
const kAgeMinValue = 18;
const kAgeMaxValue = 80;

const kProfileLocalKey = 'profile';
const kCitiesLocalKey = 'cities';
const kFiltersLocalKey = 'filters';
const kSettingsLocalKey = 'settings';

const kPostsRemoteTable = 'posts';
const kPostsQuotaExceeded = 'posts-quota-exceeded';
const kPostsCacheDuration = Duration(minutes: 5);
const kCitiesRemoteTable = 'cities';
const kCitiesCacheDuration = Duration(days: 10000);

const kTextFormPadding = EdgeInsets.all(24);
const kTextFormSpacer = SizedBox(height: 20);
const kTextFormDoubleSpacer = SizedBox(height: 40);

const kiOSDialogPadding = EdgeInsets.only(top: 8, bottom: 32);
const kAndroidDialogPadding = EdgeInsets.only(top: 8, bottom: 8);
const kDialogTitlePadding = EdgeInsets.only(top: 12);

const kDefaultContentPadding = EdgeInsets.symmetric(vertical: 8);
const kInputContentPadding = EdgeInsets.all(24);
const kPromptContentPadding = EdgeInsets.symmetric(vertical: 24);
const kSliderContentPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 8);
const kValueTilePadding = EdgeInsets.symmetric(horizontal: 24);
const kLocationContentPadding = EdgeInsets.all(24);
