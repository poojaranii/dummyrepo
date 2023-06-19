import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ich/provider/ChangeStr.dart';
import 'bottom_dashboard.dart';
import 'package:provider/provider.dart';
import 'demo.dart';
import 'editor_demo.dart';
import 'forgot_password/create_new_password/createnew_password.dart';
import 'forgot_password/forgot_password.dart';
import 'installation_screen/installation.dart';
import 'kyc_detail_screen/kyc_full_detail/kyc_detail.dart';
import 'login/login_screen.dart';
import 'mobileno_screen/mobileregister_screen.dart';
import 'navigation_screen/complaint_screen/complain.dart';
import 'navigation_screen/dashboard_screen/dashboard_screen.dart';
import 'navigation_screen/kyc_screen/kyc_screen.dart';
import 'navigation_screen/profile/basic_information/profile_information.dart';
import 'navigation_screen/profile/change_password_screen/change_password.dart';
import 'navigation_screen/profile/profil_screen/profile.dart';
import 'navigation_screen/profile/profile_setting_screen/profile_setting.dart';
import 'otp_screen/OtpScreen.dart';
import 'provider/statemanagment.dart';
import 'splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
   // systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Color(0xffFFFFFF), //// status bar color

  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool> _onWillPop(BuildContext context) async {
    bool exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }
  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Yes'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: MaterialApp(
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
         // '/': (context) => DashBoard(),
          '/second': (context) => CreateNewpasswordScreen(),
          '/third': (context) => ForgotPasswordScreen(),
        },

      ),
    );



  }
}

