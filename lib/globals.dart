import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool gbisLoggedIn = false;
String gsUserName = "";
String gsPassword = "";

// Database init
const supabaseUrl = 'https://zbqoritnaqhkridbyaxc.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpicW9yaXRuYXFoa3JpZGJ5YXhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njg2MzI0NDEsImV4cCI6MTk4NDIwODQ0MX0.NO3SvLCPEmXMFIVFiHBYV9ZLp0o2IFgndMzpkwQG_F0';
final dataBase = SupabaseClient(supabaseUrl, supabaseKey);
User? gUser;

//Shared Preferences

Future<void> initSPHelper() async {
  await SPHelper.sp.initSharedPreferences();
  //await Future.delayed(const Duration(milliseconds: 3000));
}

class SPHelper {
  SPHelper._();
  static SPHelper sp = SPHelper._();
  SharedPreferences? prefs;

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> save(String name, String value) async {
    await prefs?.setString(name, value);
  }

  String? get(String key) {
    return prefs?.getString(key) ?? "";
  }

  Future<bool> delete(String key) async {
    return await prefs!.remove(key);
  }
}

// Handle Back nutton
Future<bool> onWillPop(context) async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              //onPressed: () { Navigator.of(context).pop(true);},
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      )) ??
      false;
}
