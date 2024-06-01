import 'package:chambeape/config/utils/login_user_data.dart';
import 'package:chambeape/infrastructure/models/users.dart';
import 'package:chambeape/services/users/user_service.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  
  final int userId;

  const ProfileView({
    super.key,
    this.userId = 0,
  });

  static const String routeName = 'profile_view';

  Future<Users> _loadUserById() async {
    if (userId != 0) {
      return await UserService().getUserById(userId);
    } else {
      var session = await LoginData().loadSession();
      var userId = session.id;
      return await UserService().getUserById(userId);
    }
  }

  @override
  Widget build(BuildContext context) {

    final text = Theme.of(context).textTheme; 

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: FutureBuilder<Users>(
          future: _loadUserById(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading user data'));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.settings_outlined, size: 30),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(user.profilePic),
                            ),
                            const SizedBox(height: 10),
                            Text('${user.firstName} ${user.lastName}', style: text.titleLarge?.
                            copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                             _ConectButton(text: text),
                                    
                            const SizedBox(height: 10),
                            _Description(user: user, text: text),
                            const SizedBox(height: 10),
                          ]
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No existen datos del usuario'));
            }
          },
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final TextTheme text;

  const _Description({
    required this.user, 
    required this.text,
  });

  final Users user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Descripción', style: text.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text(user.description, style: text.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ConectButton extends StatelessWidget {
  final TextTheme text;

  const _ConectButton({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Ajusta el radio del borde aquí
          ),
        ),
        onPressed: () {
          // TODO Implementar la funcionalidad de chatear aquí
        },
        child: Text('Chatear', style: text.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}