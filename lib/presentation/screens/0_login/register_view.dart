// import 'package:chambeape/infrastructure/models/users.dart';
import 'dart:io';
import 'package:chambeape/infrastructure/models/users.dart';
import 'package:chambeape/presentation/screens/0_login/widgets/custom_radio_list_tile.dart';
import 'package:chambeape/presentation/screens/0_login/widgets/image_picker_widget.dart';
import 'package:chambeape/presentation/shared/enums/enum.dart';
import 'package:chambeape/presentation/shared/utils/custom_validators.dart';
import 'package:chambeape/services/media/MediaService.dart';
import 'package:chambeape/services/users/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  UserRole selectedUserRole = UserRole.W;
  File? selectedImage;
  Gender selectedGender = Gender.M;
  bool obscureText = true;
  Future<File?> getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      birthDateController.text = pickedDate.toString().split(" ")[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomRadioListTile(
                    groupValue: UserRole.W,
                    value1: UserRole.W,
                    label1: "Chambeador",
                    value2: UserRole.E,
                    label2: "Empleador",
                    radioName: "Tipo de Cuenta",
                    onChanged: (UserRole value) {
                      selectedUserRole = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    validator: (value) => customValidator(value, 'nombre'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Apellido',
                    ),
                    validator: (value) => customValidator(value, 'apellido'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dniController,
                    decoration: const InputDecoration(
                      labelText: 'DNI',
                    ),
                    validator: (value) => dniValidator(value),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: birthDateController,
                    validator: birthDateValidator,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de nacimiento',
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    onTap: () {
                      _selectDate();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono',
                    ),
                    validator: (value) => customValidator(value, 'teléfono'),
                  ),
                  const SizedBox(height: 10),
                  CustomRadioListTile(
                    groupValue: Gender.M,
                    value1: Gender.M,
                    label1: "Hombre",
                    value2: Gender.F,
                    label2: "Mujer",
                    radioName: "Género",
                    onChanged: (Gender value) {
                      selectedGender = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  ImagePickerWidget(
                    onTap: () async {
                      final image = await MediaService().getImageFromGallery();
                      setState(() {
                        selectedImage = image;
                      });
                    },
                    selectedImage: selectedImage,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                    ),
                    validator: (value) => emailValidator(value),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ))),
                    obscureText: obscureText,
                    validator: (value) => customValidator(value, 'contraseña'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Descripción',
                    ),
                    minLines: 3,
                    maxLines: null,
                    validator: (value) => customValidator(value, 'descripción'),
                  ),
                  FilledButton(
                    onPressed: () async {
                      Uri profilePicUri = await MediaService()
                          .saveFileToGoogleCloud(selectedImage!);
                      DateTime birthDate =
                          DateTime.parse(birthDateController.text);
                      print(birthDate);
                      if (_formKey.currentState!.validate()) {
                        Users newUser = Users(
                          firstName: nameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          phoneNumber: phoneController.text,
                          birthdate: birthDate,
                          gender: selectedGender.toString().split('.').last,
                          profilePic: profilePicUri.toString(),
                          description: descriptionController.text,
                          userRole: selectedUserRole.toString().split('.').last,
                          dni: dniController.text,
                          password: passwordController.text,
                        );
                        UserService().postUser(newUser).then(
                          (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuario registrado'),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ).catchError((error) {
                          print(newUser.toJson());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Error al registrar usuario: ${error.message}'),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text('Registrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
