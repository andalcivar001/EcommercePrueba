import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _bloc;

  @override
  Widget build(BuildContext context) {
    // _bloc = BlocProvider(create: create)
    return Container();
  }
}
