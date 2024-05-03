import 'package:flutter/material.dart';

const supabaseUrl = 'https://zqbppqfqagxfoqlclkxg.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpxYnBwcWZxYWd4Zm9xbGNsa3hnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQyMjUwOTIsImV4cCI6MjAyOTgwMTA5Mn0.H7Oyi29HRKAGClZmLQYE9o8dKUwXRjwr3bbgrH4s3Yg';

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
const kCitiesCacheDuration = Duration(days: 1000);

const kTextFormPadding = EdgeInsets.all(24);
const kTextFormSpacer = SizedBox(height: 16);
const kTextFormDoubleSpacer = SizedBox(height: 32);

const kiOSDialogPadding = EdgeInsets.only(top: 8, bottom: 32);
const kAndroidDialogPadding = EdgeInsets.only(top: 8, bottom: 8);
const kDialogTitlePadding = EdgeInsets.only(top: 12);

const kDefaultContentPadding = EdgeInsets.symmetric(vertical: 8);
const kInputContentPadding = EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 24);
const kPromptContentPadding = EdgeInsets.symmetric(vertical: 24);
const kSliderContentPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 8);
const kValueTilePadding = EdgeInsets.symmetric(horizontal: 24);
