import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basic/login/presentation/loginPage.dart';
import 'package:flutter_basic/register/application/registerAuth.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';

const List<String> list = <String>['ALUNO', 'PROFESSOR', 'STAFF'];
const List<String> listStaff = <String>[
  'SEGURANÇA',
  'BIBLIOTECA',
  'DIREÇÃO',
  'DIVULGAÇÃO'
];

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterHome();
}

class RegisterHome extends State<Register> {
  bool passwordVisible = true;
  bool passwordConfVisible = true;
  late Uint8List selectedImageInBytes;
  String selectFile = "";
  String postId = Uuid().v4();

  late TextEditingController usernameControl;
  late TextEditingController nameControl;
  late TextEditingController emailControl;
  late TextEditingController pwdControl;
  late TextEditingController pwdConfirmControl;
  late TextEditingController roleControl;
  late TextEditingController staffRoleControl;
  late TextEditingController departmentControl;
  late TextEditingController descrpControl;
  late TextEditingController numberControl;

  @override
  void initState() {
    usernameControl = TextEditingController();
    nameControl = TextEditingController();
    emailControl = TextEditingController();
    pwdControl = TextEditingController();
    pwdConfirmControl = TextEditingController();
    roleControl = TextEditingController();
    staffRoleControl = TextEditingController();
    departmentControl = TextEditingController();
    descrpControl = TextEditingController();
    numberControl = TextEditingController();

    super.initState();
  }

  String roleValue = list.first;
  String staffRoleValue = listStaff.first;


  handleChoosePhoto(context) async {
    print("1");
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      setState(() {
        selectFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes!;
      });
    }
    Navigator.pop(context);

  }

  Future<String> uploadFile() async {
    UploadTask uploadTask;
    Reference storageRef =
    fireBaseStorageInstance.ref().child("/profile/" + postId);

    final metadata = SettableMetadata(contentType: 'image/jpeg');
    uploadTask = storageRef.putData(selectedImageInBytes, metadata);

    await uploadTask.whenComplete(() => null);
    String imageUrl = "";
    imageUrl = await storageRef.getDownloadURL();
    return imageUrl;

  }




  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Imagem'),
            children: [
              SimpleDialogOption(
                child: Text('Escolhe da galeria'),
                onPressed: () {
                  handleChoosePhoto(context);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  Future<void> RegisterButtonPressed(
    String username,
    String email,
    String name,
    String pwd,
    String role,
    int studentNumber,
    String department,
    String description,
    BuildContext context,
  ) async {
    print(role);
    String url = await uploadFile();
    if (role == "ALUNO") {
      RegisterAuth.registerStudent(username, name, pwd, email, role,
              studentNumber, description, department, url)
          .then((value) {
        if (value) {
          // Display success message
          RegisterDone(context);
        }
      });
    } else {
      RegisterAuth.registerStaff(
              username, name, pwd, email, role, description, department, url)
          .then((value) {
        if (value) {
          // Display success message
          RegisterDone(context);
        }
      });
    }
  }

  void RegisterDone(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('Your registration was successful.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                ); // Navigate to the login screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/campus-1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/logo-1-RBH.png', height: 65),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      width: 450,
                      decoration: BoxDecoration(
                        color: const Color(0xd8ffffff),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Registo',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: usernameControl,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: nameControl,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nome',
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                obscureText: passwordVisible,
                                controller: pwdControl,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                obscureText: passwordConfVisible,
                                controller: pwdConfirmControl,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Confirma Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordConfVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordConfVisible =
                                            !passwordConfVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: emailControl,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    width: 130,
                                    child: DropdownButton(
                                      value: roleValue,
                                      onChanged: (String? selected) {
                                        if (selected is String) {
                                          setState(() {
                                            roleValue = selected;
                                          });
                                        }
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Visibility(
                                  visible: roleValue == 'STAFF',
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      width: 135,
                                      child: DropdownButton(
                                        value: staffRoleValue,
                                        onChanged: (String? selected) {
                                          if (selected is String) {
                                            setState(() {
                                              staffRoleValue = selected;
                                              if (roleValue == 'STAFF') {
                                                roleControl.text = selected;
                                              }
                                            });
                                          }
                                        },
                                        items: listStaff
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: roleValue == 'ALUNO',
                                  child: const SizedBox(width: 10),
                                ),
                                const SizedBox(width: 10),
                                Visibility(
                                  visible: roleValue == 'ALUNO',
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: SizedBox(
                                      width: 110,
                                      child: TextField(
                                        controller: numberControl,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Número de Aluno',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 13),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: departmentControl,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Departamento',
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: descrpControl,
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                maxLength: 400,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Descrição',
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            ElevatedButton(
                              onPressed: () {
                                selectImage(context);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(150, 50),
                                backgroundColor: Colors.blue[800],
                              ),
                              child: Text(
                                'Adicionar foto',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            const SizedBox(height: 13),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size(200, 50),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                if (RegisterAuth.emptyFields(
                                  usernameControl.text,
                                  emailControl.text,
                                  nameControl.text,
                                  pwdControl.text,
                                  pwdConfirmControl.text,
                                  roleValue == 'ALUNO'
                                      ? numberControl.text.isEmpty
                                          ? 0
                                          : int.parse(numberControl.text)
                                      : -1,
                                )) {
                                  mandatoryFieldsBox(context);
                                } else if (RegisterAuth.hasSpecialChars(
                                    pwdControl.text)) {
                                  invalidCaracteresBox(context);
                                } else if (pwdConfirmControl.text !=
                                    pwdControl.text) {
                                  differentPasswordsBox(context);
                                } else if (!RegisterAuth.isPasswordCompliant(
                                    pwdControl.text)) {
                                  validPasswordBox(context);
                                } else if (roleValue == 'ALUNO' &&
                                    !RegisterAuth.checkEmailFormatStudent(
                                        emailControl.text)) {
                                  emailFormatErrorBox(context);
                                } else if ((roleValue == 'PROFESSOR' ||
                                        roleValue == 'STAFF') &&
                                    !RegisterAuth.checkEmailFormatStaff(
                                        emailControl.text)) {
                                  emailFormatErrorBox(context);
                                } else {
                                  RegisterButtonPressed(
                                    usernameControl.text,
                                    emailControl.text,
                                    nameControl.text,
                                    pwdControl.text,
                                    roleValue == 'STAFF'
                                        ? staffRoleValue
                                        : roleValue,
                                    roleValue == 'ALUNO'
                                        ? int.parse(numberControl.text)
                                        : -1,
                                    departmentControl.text,
                                    descrpControl.text,
                                    context,
                                  );
                                  debugPrint('Received click');
                                }
                              },
                              child: const Text(
                                'Registar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              child: const Text('Voltar'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 13),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validPasswordBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password tem de ter no mínimo 5 caracteres,'
              'letra maiúscula e um número'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void differentPasswordsBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Passwords são diferentes!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void invalidCaracteresBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password contém caracteres inválidos'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void mandatoryFieldsBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              'Campos obrigatórios por preencher: Username, nome, password e email e numero de aluno'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void emailFormatErrorBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email não tem o formato correto!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
