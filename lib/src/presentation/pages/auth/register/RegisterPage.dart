import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/RegisterContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              AppToast.error(responseState.message);
            } else if (responseState is Success) {
              AppToast.success('Usuario creado correctamente');
              _bloc?.add(ResetFormRegisterEvent());
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              final r = state.response;

              return Stack(
                children: [
                  RegisterContent(_bloc, state),

                  if (r is Loading)
                    const Positioned.fill(
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
