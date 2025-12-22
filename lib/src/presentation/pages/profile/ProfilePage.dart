import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/ProfileContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              AppToast.error(responseState.message);
            } else if (responseState is Success) {
              User user = responseState.data;
              AppToast.success('Usuario ${user.id} actualizado correctamente');
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final res = state.response;
              return Stack(
                children: [
                  ProfileContent(_bloc, state, state.user),
                  if (res is Loading)
                    Positioned.fill(
                      child: ColoredBox(
                        color: Color(0x66000000),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
