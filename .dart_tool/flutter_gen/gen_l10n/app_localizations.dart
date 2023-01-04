import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @login_welcomeback.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get login_welcomeback;

  /// No description provided for @login_forgotpassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get login_forgotpassword;

  /// No description provided for @login_signin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get login_signin;

  /// No description provided for @login_signinwith.
  ///
  /// In en, this message translates to:
  /// **'Sign in with:'**
  String get login_signinwith;

  /// No description provided for @login_clickhere.
  ///
  /// In en, this message translates to:
  /// **'Click here'**
  String get login_clickhere;

  /// No description provided for @login_notamember.
  ///
  /// In en, this message translates to:
  /// **'Not a member?'**
  String get login_notamember;

  /// No description provided for @login_signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get login_signup;

  /// No description provided for @signup_username.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get signup_username;

  /// No description provided for @signup_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signup_password;

  /// No description provided for @signup_repeatpassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get signup_repeatpassword;

  /// No description provided for @signup_createaccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signup_createaccount;

  /// No description provided for @homepage_map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get homepage_map;

  /// No description provided for @homepage_stations.
  ///
  /// In en, this message translates to:
  /// **'Stations'**
  String get homepage_stations;

  /// No description provided for @homepage_prizes.
  ///
  /// In en, this message translates to:
  /// **'Prizes'**
  String get homepage_prizes;

  /// No description provided for @homepage_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get homepage_profile;

  /// No description provided for @route_origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get route_origin;

  /// No description provided for @route_searchorigin.
  ///
  /// In en, this message translates to:
  /// **'Search origin'**
  String get route_searchorigin;

  /// No description provided for @route_destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get route_destination;

  /// No description provided for @route_searchdestination.
  ///
  /// In en, this message translates to:
  /// **'Search destination'**
  String get route_searchdestination;

  /// No description provided for @personallocation_header.
  ///
  /// In en, this message translates to:
  /// **'New personal location'**
  String get personallocation_header;

  /// No description provided for @personallocation_addtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a title to your location'**
  String get personallocation_addtitle;

  /// No description provided for @personallocation_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get personallocation_title;

  /// No description provided for @personallocation_adddescription.
  ///
  /// In en, this message translates to:
  /// **'Add a description to your location'**
  String get personallocation_adddescription;

  /// No description provided for @personallocation_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get personallocation_description;

  /// No description provided for @personallocation_submit.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get personallocation_submit;

  /// No description provided for @reservation_title.
  ///
  /// In en, this message translates to:
  /// **'Book a charging slot'**
  String get reservation_title;

  /// No description provided for @reservation_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reservation_date;

  /// No description provided for @reservation_starttime.
  ///
  /// In en, this message translates to:
  /// **'From:'**
  String get reservation_starttime;

  /// No description provided for @reservation_endtime.
  ///
  /// In en, this message translates to:
  /// **'To:'**
  String get reservation_endtime;

  /// No description provided for @bicingstation_mechanical.
  ///
  /// In en, this message translates to:
  /// **'Mechanical bikes'**
  String get bicingstation_mechanical;

  /// No description provided for @bicingstation_electrical.
  ///
  /// In en, this message translates to:
  /// **'Electrical bikes'**
  String get bicingstation_electrical;

  /// No description provided for @bicingstation_slots.
  ///
  /// In en, this message translates to:
  /// **'Empty slots'**
  String get bicingstation_slots;

  /// No description provided for @rechargestation_speed.
  ///
  /// In en, this message translates to:
  /// **'Speed type'**
  String get rechargestation_speed;

  /// No description provided for @rechargestation_connection.
  ///
  /// In en, this message translates to:
  /// **'Connection type'**
  String get rechargestation_connection;

  /// No description provided for @rechargestation_slots.
  ///
  /// In en, this message translates to:
  /// **'Empty slots'**
  String get rechargestation_slots;

  /// No description provided for @profile_personallocations.
  ///
  /// In en, this message translates to:
  /// **'Personal locations'**
  String get profile_personallocations;

  /// No description provided for @profile_nolocations.
  ///
  /// In en, this message translates to:
  /// **'No personal locations found'**
  String get profile_nolocations;

  /// No description provided for @profile_favouritestations.
  ///
  /// In en, this message translates to:
  /// **'Favourite stations'**
  String get profile_favouritestations;

  /// No description provided for @profile_nostations.
  ///
  /// In en, this message translates to:
  /// **'No favourite stations found'**
  String get profile_nostations;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profile_logout;

  /// No description provided for @profile_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profile_delete;

  /// No description provided for @profile_checkdelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get profile_checkdelete;

  /// No description provided for @expandedStation_noComments.
  ///
  /// In en, this message translates to:
  /// **'There\'s no comments yet'**
  String get expandedStation_noComments;

  /// No description provided for @expandedStation_favButton.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get expandedStation_favButton;

  /// No description provided for @expandedStation_addComment.
  ///
  /// In en, this message translates to:
  /// **'Add Comment'**
  String get expandedStation_addComment;

  /// No description provided for @expandedStation_editComment.
  ///
  /// In en, this message translates to:
  /// **'Edit Comment'**
  String get expandedStation_editComment;

  /// No description provided for @editprofile_oldpassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get editprofile_oldpassword;

  /// No description provided for @editprofile_newpassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get editprofile_newpassword;

  /// No description provided for @editprofile_repeatnewpassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat new password'**
  String get editprofile_repeatnewpassword;

  /// No description provided for @editprofile_confirm_changes.
  ///
  /// In en, this message translates to:
  /// **'Confirm new changes'**
  String get editprofile_confirm_changes;

  /// No description provided for @editprofile_cancel_changes.
  ///
  /// In en, this message translates to:
  /// **'Cancel changes'**
  String get editprofile_cancel_changes;

  /// No description provided for @editprofile_text.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get editprofile_text;

}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
