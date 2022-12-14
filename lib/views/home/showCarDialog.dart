import 'dart:io';

import 'package:fire_cars/model/carModel.dart';
import 'package:fire_cars/services/dbservices.dart';
import 'package:fire_cars/shared-ui/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarDialog {
  User? user;
  CarDialog({this.user});

  // pour visualiser la boîte de dialogue

  void showCarDialog(BuildContext context, ImageSource source) async {
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);
    final _keyForm = GlobalKey<FormState>();
    String _carName = '';
    String _formError = 'Veuillez fornir le nom de la voiture';

    showDialog(
        context: context,
        builder: (BuildContext) {
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: FileImage(_file),
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                      key: _keyForm,
                      child: TextFormField(
                        maxLength: 20,
                        onChanged: (value) => _carName = value,
                        validator: (value) =>
                            _carName == '' ? _formError : null,
                        decoration: InputDecoration(
                          labelText: 'Nom vde la voiture',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('ANNULER'),
                          ),
                          ElevatedButton(
                            onPressed: () => onSubmit(context, _keyForm, _file, _carName, user),
                            child: Text('PUBLIER'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  Future<void> onSubmit(context, keyForm, file, carName, user) async {
    if (keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Chargement...");
      DatabaseService db = DatabaseService();
      String _carUrlImg = await db.uploadFile(file);
      db.addCar(Car(
          carName: carName,
          carUrlImg: _carUrlImg,
          carUserID: user!.uid,
          carUserName: user!.displayName));
    }
  }
}
