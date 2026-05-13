import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../../authentication/bloc/authentication_event.dart';
import '../../profile/view/profile_page.dart';
import '../../theme/cubit/theme_cubit.dart';

import '../../authentication/repository/authentication_repository.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authenticationRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    final currentUser = authenticationRepository.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },

            icon: const Icon(Icons.person),
          ),

          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },

                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons
                            .dark_mode // bisa di ubah logika nya agar jika saat terang maka icon nya tetap light_mode
                      : Icons.light_mode, // --||--
                ),
              );
            },
          ),

          IconButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(
                AuthenticationLogoutRequested(),
              );
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      // TAMBAHAN COLUMN
      body: Column(
        children: [
          Container(
            width: double.infinity,

            padding: const EdgeInsets.all(16),

            color: Colors.blue.shade100,

            child: Text(
              'Login sebagai: '
              '${currentUser?.email}',

              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,

                  itemBuilder: (context, index) {
                    final data = docs[index];

                    final id = data.id;

                    final email = data['email'];

                    return ListTile(
                      leading: const Icon(Icons.person),

                      title: Text(email),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          // UPDATE
                          IconButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(id)
                                  .update({'email': 'updated_$email'});
                            },

                            icon: const Icon(Icons.edit),
                          ),

                          // DELETE
                          IconButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(id)
                                  .delete();
                            },

                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}