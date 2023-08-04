// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Where are you looking to advertise?`
  String get whereAreYouLookingToAdvertise {
    return Intl.message(
      'Where are you looking to advertise?',
      name: 'whereAreYouLookingToAdvertise',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `E-Mail`
  String get email {
    return Intl.message(
      'E-Mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Password`
  String get repeatPassword {
    return Intl.message(
      'Repeat Password',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up with Google`
  String get signUpWithGoogle {
    return Intl.message(
      'Sign Up with Google',
      name: 'signUpWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up with Apple`
  String get signUpWithApple {
    return Intl.message(
      'Sign Up with Apple',
      name: 'signUpWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Verify your E-Mail`
  String get verifyYourEmail {
    return Intl.message(
      'Verify your E-Mail',
      name: 'verifyYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code we sent over E-Mail to`
  String get enterTheCodeWeSentOverEmailTo {
    return Intl.message(
      'Enter the code we sent over E-Mail to',
      name: 'enterTheCodeWeSentOverEmailTo',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Please select a date`
  String get pleaseSelectADate {
    return Intl.message(
      'Please select a date',
      name: 'pleaseSelectADate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a text`
  String get pleaseEnterAText {
    return Intl.message(
      'Please enter a text',
      name: 'pleaseEnterAText',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMustBeAtLeast6Characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMustBeAtLeast6Characters',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get pleaseEnterAValidEmailAddress {
    return Intl.message(
      'Please enter a valid email address',
      name: 'pleaseEnterAValidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get pleaseEnterAValidPhoneNumber {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'pleaseEnterAValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Log In with Google`
  String get logInWithGoogle {
    return Intl.message(
      'Log In with Google',
      name: 'logInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Log In with Apple`
  String get logInWithApple {
    return Intl.message(
      'Log In with Apple',
      name: 'logInWithApple',
      desc: '',
      args: [],
    );
  }

  /// `New Here?`
  String get newHere {
    return Intl.message(
      'New Here?',
      name: 'newHere',
      desc: '',
      args: [],
    );
  }

  /// `Enter Location`
  String get enterLocation {
    return Intl.message(
      'Enter Location',
      name: 'enterLocation',
      desc: '',
      args: [],
    );
  }

  /// `Indoor Ads`
  String get indoorAds {
    return Intl.message(
      'Indoor Ads',
      name: 'indoorAds',
      desc: '',
      args: [],
    );
  }

  /// `Outdoor Ads`
  String get outdoorAds {
    return Intl.message(
      'Outdoor Ads',
      name: 'outdoorAds',
      desc: '',
      args: [],
    );
  }

  /// `Digital Ads`
  String get digitalAds {
    return Intl.message(
      'Digital Ads',
      name: 'digitalAds',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Ads`
  String get vehicleAds {
    return Intl.message(
      'Vehicle Ads',
      name: 'vehicleAds',
      desc: '',
      args: [],
    );
  }

  /// `Popular Ad Spaces`
  String get popularAdSpaces {
    return Intl.message(
      'Popular Ad Spaces',
      name: 'popularAdSpaces',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `My Ad Spaces`
  String get myAdSpaces {
    return Intl.message(
      'My Ad Spaces',
      name: 'myAdSpaces',
      desc: '',
      args: [],
    );
  }

  /// `My Listings`
  String get myListings {
    return Intl.message(
      'My Listings',
      name: 'myListings',
      desc: '',
      args: [],
    );
  }

  /// `Edit or view your AD listings here`
  String get editOrViewYourAdListingsHere {
    return Intl.message(
      'Edit or view your AD listings here',
      name: 'editOrViewYourAdListingsHere',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Post AD Space`
  String get postAdSpace {
    return Intl.message(
      'Post AD Space',
      name: 'postAdSpace',
      desc: '',
      args: [],
    );
  }

  /// `Hey`
  String get hey {
    return Intl.message(
      'Hey',
      name: 'hey',
      desc: '',
      args: [],
    );
  }

  /// `Tell us about your AD Space`
  String get tellUsAboutYourAdSpace {
    return Intl.message(
      'Tell us about your AD Space',
      name: 'tellUsAboutYourAdSpace',
      desc: '',
      args: [],
    );
  }

  /// `The more you share, the quicker you get booked.`
  String get theMoreYouShareTheQuickerYouGetBooked {
    return Intl.message(
      'The more you share, the quicker you get booked.',
      name: 'theMoreYouShareTheQuickerYouGetBooked',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get selectLocation {
    return Intl.message(
      'Select Location',
      name: 'selectLocation',
      desc: '',
      args: [],
    );
  }

  /// `You can move the map to set the location of your place`
  String get youCanMoveTheMapToSetTheLocationOf {
    return Intl.message(
      'You can move the map to set the location of your place',
      name: 'youCanMoveTheMapToSetTheLocationOf',
      desc: '',
      args: [],
    );
  }

  /// `Enter your address`
  String get enterYourAddress {
    return Intl.message(
      'Enter your address',
      name: 'enterYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Give us location details to find your ad easily`
  String get giveUsLocationDetailsToFindYourAdEasily {
    return Intl.message(
      'Give us location details to find your ad easily',
      name: 'giveUsLocationDetailsToFindYourAdEasily',
      desc: '',
      args: [],
    );
  }

  /// `Enter your state`
  String get enterYourState {
    return Intl.message(
      'Enter your state',
      name: 'enterYourState',
      desc: '',
      args: [],
    );
  }

  /// `Enter your city`
  String get enterYourCity {
    return Intl.message(
      'Enter your city',
      name: 'enterYourCity',
      desc: '',
      args: [],
    );
  }

  /// `Enter your country`
  String get enterYourCountry {
    return Intl.message(
      'Enter your country',
      name: 'enterYourCountry',
      desc: '',
      args: [],
    );
  }

  /// `Enter your zip code`
  String get enterYourZipCode {
    return Intl.message(
      'Enter your zip code',
      name: 'enterYourZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all the fields`
  String get pleaseFillAllTheFields {
    return Intl.message(
      'Please fill all the fields',
      name: 'pleaseFillAllTheFields',
      desc: '',
      args: [],
    );
  }

  /// `Choose a type of ad`
  String get chooseATypeOfAd {
    return Intl.message(
      'Choose a type of ad',
      name: 'chooseATypeOfAd',
      desc: '',
      args: [],
    );
  }

  /// `Ad Type`
  String get adType {
    return Intl.message(
      'Ad Type',
      name: 'adType',
      desc: '',
      args: [],
    );
  }

  /// `Choose a space type`
  String get chooseASpaceType {
    return Intl.message(
      'Choose a space type',
      name: 'chooseASpaceType',
      desc: '',
      args: [],
    );
  }

  /// `Space Type`
  String get spaceType {
    return Intl.message(
      'Space Type',
      name: 'spaceType',
      desc: '',
      args: [],
    );
  }

  /// `Give us your ad details`
  String get giveUsYourAdDetails {
    return Intl.message(
      'Give us your ad details',
      name: 'giveUsYourAdDetails',
      desc: '',
      args: [],
    );
  }

  /// `Installation Date`
  String get installationDate {
    return Intl.message(
      'Installation Date',
      name: 'installationDate',
      desc: '',
      args: [],
    );
  }

  /// `Removal Date`
  String get removalDate {
    return Intl.message(
      'Removal Date',
      name: 'removalDate',
      desc: '',
      args: [],
    );
  }

  /// `Upload photos`
  String get uploadPhotos {
    return Intl.message(
      'Upload photos',
      name: 'uploadPhotos',
      desc: '',
      args: [],
    );
  }

  /// `About Ad Space`
  String get aboutAdSpace {
    return Intl.message(
      'About Ad Space',
      name: 'aboutAdSpace',
      desc: '',
      args: [],
    );
  }

  /// `Just a few more details left`
  String get justAFewMoreDetailsLeft {
    return Intl.message(
      'Just a few more details left',
      name: 'justAFewMoreDetailsLeft',
      desc: '',
      args: [],
    );
  }

  /// `You're almost there!`
  String get youreAlmostThere {
    return Intl.message(
      'You\'re almost there!',
      name: 'youreAlmostThere',
      desc: '',
      args: [],
    );
  }

  /// `Take new photos`
  String get takeNewPhotos {
    return Intl.message(
      'Take new photos',
      name: 'takeNewPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Add Photos`
  String get addPhotos {
    return Intl.message(
      'Add Photos',
      name: 'addPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Add your price ($ / per day)`
  String get addYourPricePerDay {
    return Intl.message(
      'Add your price (\$ / per day)',
      name: 'addYourPricePerDay',
      desc: '',
      args: [],
    );
  }

  /// `$0.00`
  String get addPriceHintText {
    return Intl.message(
      '\$0.00',
      name: 'addPriceHintText',
      desc: '',
      args: [],
    );
  }

  /// `Add a title`
  String get addATitle {
    return Intl.message(
      'Add a title',
      name: 'addATitle',
      desc: '',
      args: [],
    );
  }

  /// `Give your ad space a name`
  String get giveYourAdSpaceAName {
    return Intl.message(
      'Give your ad space a name',
      name: 'giveYourAdSpaceAName',
      desc: '',
      args: [],
    );
  }

  /// `Add a description`
  String get addADescription {
    return Intl.message(
      'Add a description',
      name: 'addADescription',
      desc: '',
      args: [],
    );
  }

  /// `You can write information about this ad space`
  String get youCanWriteInformationAboutThisAdSpace {
    return Intl.message(
      'You can write information about this ad space',
      name: 'youCanWriteInformationAboutThisAdSpace',
      desc: '',
      args: [],
    );
  }

  /// `Size of AD`
  String get sizeOfAd {
    return Intl.message(
      'Size of AD',
      name: 'sizeOfAd',
      desc: '',
      args: [],
    );
  }

  /// `00 inches`
  String get Inches {
    return Intl.message(
      '00 inches',
      name: 'Inches',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Policy`
  String get cancelPolicy {
    return Intl.message(
      'Cancel Policy',
      name: 'cancelPolicy',
      desc: '',
      args: [],
    );
  }

  /// `By clicking the finish button, you accept the terms of cancellation of listing.`
  String get byClickingTheFinishButtonYouAcceptTheTermsOf {
    return Intl.message(
      'By clicking the finish button, you accept the terms of cancellation of listing.',
      name: 'byClickingTheFinishButtonYouAcceptTheTermsOf',
      desc: '',
      args: [],
    );
  }

  /// `click here to read more`
  String get clickHereToReadMore {
    return Intl.message(
      'click here to read more',
      name: 'clickHereToReadMore',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Identity Verification`
  String get identityVerification {
    return Intl.message(
      'Identity Verification',
      name: 'identityVerification',
      desc: '',
      args: [],
    );
  }

  /// `Enter Shipping Address`
  String get enterShippingAddress {
    return Intl.message(
      'Enter Shipping Address',
      name: 'enterShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add your shipping address`
  String get addYourShippingAddress {
    return Intl.message(
      'Add your shipping address',
      name: 'addYourShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid address`
  String get pleaseEnterValidAddress {
    return Intl.message(
      'Please enter valid address',
      name: 'pleaseEnterValidAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your shipping address`
  String get pleaseEnterYourShippingAddress {
    return Intl.message(
      'Please enter your shipping address',
      name: 'pleaseEnterYourShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Take a Picture Of ID`
  String get takeAPictureOfId {
    return Intl.message(
      'Take a Picture Of ID',
      name: 'takeAPictureOfId',
      desc: '',
      args: [],
    );
  }

  /// `Take picture`
  String get takePicture {
    return Intl.message(
      'Take picture',
      name: 'takePicture',
      desc: '',
      args: [],
    );
  }

  /// `Take a picture of the front and back of your ID and make it fit within the frame - check for good lighting`
  String get takeAPictureOfTheFrontAndBackOfYour {
    return Intl.message(
      'Take a picture of the front and back of your ID and make it fit within the frame - check for good lighting',
      name: 'takeAPictureOfTheFrontAndBackOfYour',
      desc: '',
      args: [],
    );
  }

  /// `The data you share will be encrypted, stored securely, and only used to verify your identity`
  String get theDataYouShareWillBeEncryptedStoredSecurelyAnd {
    return Intl.message(
      'The data you share will be encrypted, stored securely, and only used to verify your identity',
      name: 'theDataYouShareWillBeEncryptedStoredSecurelyAnd',
      desc: '',
      args: [],
    );
  }

  /// `Error initializing camera`
  String get errorInitializingCamera {
    return Intl.message(
      'Error initializing camera',
      name: 'errorInitializingCamera',
      desc: '',
      args: [],
    );
  }

  /// `Fit the front of your ID within the frame`
  String get fitTheFrontOfYourIdWithinTheFrame {
    return Intl.message(
      'Fit the front of your ID within the frame',
      name: 'fitTheFrontOfYourIdWithinTheFrame',
      desc: '',
      args: [],
    );
  }

  /// `Front Of ID`
  String get frontOfId {
    return Intl.message(
      'Front Of ID',
      name: 'frontOfId',
      desc: '',
      args: [],
    );
  }

  /// `Back of ID`
  String get backOfId {
    return Intl.message(
      'Back of ID',
      name: 'backOfId',
      desc: '',
      args: [],
    );
  }

  /// `Fit the back of your ID within the frame`
  String get fitTheBackOfYourIdWithinTheFrame {
    return Intl.message(
      'Fit the back of your ID within the frame',
      name: 'fitTheBackOfYourIdWithinTheFrame',
      desc: '',
      args: [],
    );
  }

  /// `Your ID has been verified successfully`
  String get yourIdHasBeenVerifiedSuccessfully {
    return Intl.message(
      'Your ID has been verified successfully',
      name: 'yourIdHasBeenVerifiedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a different tag name, this is ad type name`
  String get pleaseEnterADifferentTagNameThisIsAdType {
    return Intl.message(
      'Please enter a different tag name, this is ad type name',
      name: 'pleaseEnterADifferentTagNameThisIsAdType',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a different tag name, this is type name`
  String get pleaseEnterADifferentTagNameThisIsTypeName {
    return Intl.message(
      'Please enter a different tag name, this is type name',
      name: 'pleaseEnterADifferentTagNameThisIsTypeName',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `You haven’t added any payment methods. Add a payment method`
  String get youHaventAddedAnyPaymentMethodsAddAPaymentMethod {
    return Intl.message(
      'You haven’t added any payment methods. Add a payment method',
      name: 'youHaventAddedAnyPaymentMethodsAddAPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Add Payment Method`
  String get addPaymentMethod {
    return Intl.message(
      'Add Payment Method',
      name: 'addPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Add some payment methods to make your booking process faster and easier.`
  String get addSomePaymentMethodsToMakeYourBookingProcessFaster {
    return Intl.message(
      'Add some payment methods to make your booking process faster and easier.',
      name: 'addSomePaymentMethodsToMakeYourBookingProcessFaster',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw from your balance`
  String get withdrawFromYourBalance {
    return Intl.message(
      'Withdraw from your balance',
      name: 'withdrawFromYourBalance',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `You don't have enough balance to withdraw`
  String get youDontHaveEnoughBalanceToWithdraw {
    return Intl.message(
      'You don\'t have enough balance to withdraw',
      name: 'youDontHaveEnoughBalanceToWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number`
  String get changePhoneNumber {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Verify your ID`
  String get verifyYourId {
    return Intl.message(
      'Verify your ID',
      name: 'verifyYourId',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Price range`
  String get priceRange {
    return Intl.message(
      'Price range',
      name: 'priceRange',
      desc: '',
      args: [],
    );
  }

  /// `Type of space`
  String get typeOfSpace {
    return Intl.message(
      'Type of space',
      name: 'typeOfSpace',
      desc: '',
      args: [],
    );
  }

  /// `Space Size`
  String get spaceSize {
    return Intl.message(
      'Space Size',
      name: 'spaceSize',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Clear all`
  String get clearAll {
    return Intl.message(
      'Clear all',
      name: 'clearAll',
      desc: '',
      args: [],
    );
  }

  /// `Recent Searches`
  String get recentSearches {
    return Intl.message(
      'Recent Searches',
      name: 'recentSearches',
      desc: '',
      args: [],
    );
  }

  /// `Listing Details`
  String get listingDetails {
    return Intl.message(
      'Listing Details',
      name: 'listingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get goBack {
    return Intl.message(
      'Go Back',
      name: 'goBack',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your ID to post an ad`
  String get pleaseVerifyYourIdToPostAnAd {
    return Intl.message(
      'Please verify your ID to post an ad',
      name: 'pleaseVerifyYourIdToPostAnAd',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
