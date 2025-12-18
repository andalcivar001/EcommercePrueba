import 'package:flutter/material.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return _buildBackground(child: Stack(alignment: Alignment.center));
  }

  Widget _buildBackground({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }

  Widget _noImageAvatar() {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
      child: Icon(Icons.person, size: 45, color: Color(0xFF1E3C72)),
    );
  }

  Widget _imageAvatar(String image) {
    return CircleAvatar(radius: 40, backgroundImage: NetworkImage(image));
  }
}
