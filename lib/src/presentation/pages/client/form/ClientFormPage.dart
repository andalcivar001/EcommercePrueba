import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/ClientformContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormState.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientFormPage extends StatefulWidget {
  const ClientFormPage({super.key});

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  ClientFormBloc? bloc;
  String? id;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _initialized) return;
      bloc = BlocProvider.of<ClientFormBloc>(context);

      final args = ModalRoute.of(context)?.settings.arguments;
      id = args is String ? args : null;

      bloc?.add(InitClientFormEvent(id: id ?? ''));

      _initialized = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    bloc?.add(ResetFormClientFormEvent());
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ClientFormBloc>(context);
    return Scaffold(
      body: BlocListener<ClientFormBloc, ClientFormState>(
        listener: (context, state) {
          final responseState = state.response;
          final responseProvinces = state.responseProvinces;
          final responseCities = state.responseCities;
          if (responseState is Success) {
            AppToast.success('Cliente guaradado correctamente');
            context.read<ClientListBloc>().add(InitClientListEvent());
          } else if (responseState is Error) {
            AppToast.error(
              'Error al guardar el cliente ${responseState.message}',
            );
          }

          if (responseProvinces is Error) {
            AppToast.error(
              'Error al obtener las provincias ${responseProvinces.message}',
            );
          }

          if (responseCities is Error) {
            AppToast.error(
              'Error al obtener las subcategorias ${responseCities.message}',
            );
          }
        },
        child: BlocBuilder<ClientFormBloc, ClientFormState>(
          builder: (context, state) {
            final response = state.response;
            final responseProvinces = state.responseProvinces;
            final responseCities = state.responseCities;

            return Stack(
              children: [
                ClientFormContent(bloc, state),
                if (response is Loading ||
                    responseProvinces is Loading ||
                    responseCities is Loading ||
                    state.loading == true)
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
    );
  }
}
