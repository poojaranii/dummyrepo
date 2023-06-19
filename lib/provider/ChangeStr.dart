
import 'package:flutter/material.dart';
import 'package:ich/provider/valiationitem.dart';
class ChangeStr with ChangeNotifier{
  String str = "";

  ValidationItem _firstName = ValidationItem(null!,null!);

  //Getters
  ValidationItem get firstName => _firstName;
  void counterUpdate() {
    notifyListeners();
  }
  bool get isValid {
    if (_firstName.value != null){
      return true;
    } else {
      return false;
    }
  }


  //Setters
  void changeFirstName(String value){
    if (value.length >= 3){
      _firstName=ValidationItem(value,null!);
    } else {
      _firstName=ValidationItem(null!, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void submitData(){
    print("FirstName: ${firstName.value}");
  }
}

