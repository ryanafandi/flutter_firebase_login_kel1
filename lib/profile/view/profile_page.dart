import 'package:flutter/material.dart';

import '../../authentication/repository/authentication_repository.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage>
      createState() =>
          _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {

  final authenticationRepository =
      AuthenticationRepository();

  final nameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    final currentUser =
        authenticationRepository
            .currentUser;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Profile'),
      ),

      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(
            24,
          ),

          child: Card(
            elevation: 10,

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child: Padding(
              padding:
                  const EdgeInsets.all(
                24,
              ),

              child: Column(
                mainAxisSize:
                    MainAxisSize.min,

                children: [

                  const CircleAvatar(
                    radius: 50,

                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // DISPLAY NAME
                  Text(
                    currentUser
                            ?.displayName ??
                        'No Name',

                    style:
                        const TextStyle(
                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // EMAIL
                  Text(
                    currentUser
                            ?.email ??
                        'No Email',

                    style:
                        const TextStyle(
                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // UID
                  Text(
                    'UID:\n'
                    '${currentUser?.uid}',

                    textAlign:
                        TextAlign.center,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //TEXTFIELD
                  TextField(
                    controller:
                        nameController,

                    decoration:
                        const InputDecoration(
                      labelText:
                          'Display Name',

                      border:
                          OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width:
                        double.infinity,

                    child:
                        ElevatedButton(
                      onPressed:
                          () async {

                        await authenticationRepository
                            .updateDisplayName(
                          nameController
                              .text,
                        );

                        setState(() {});
                      },

                      child:
                          const Text(
                        'Update Profile',
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
}