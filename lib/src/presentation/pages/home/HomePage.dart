import 'package:ecommerce_prueba/main.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc? _bloc;

  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('Dashboard')),
    Center(child: Text('Perfil')),
    Center(child: Text('Configuración')),
  ];

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Panel de Administración',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3C72),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // 👈 color del menú hamburguesa
        ),
      ),

      drawer: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Drawer(
            child: Column(
              children: [
                /// HEADER
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 45,
                          color: Color(0xFF1E3C72),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Administrador',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'admin@ecommerce.com',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                /// ITEMS
                _drawerItem(
                  icon: Icons.dashboard_outlined,
                  text: 'Dashboard',
                  index: 0,
                ),
                _drawerItem(
                  icon: Icons.person_outline,
                  text: 'Perfil',
                  index: 1,
                ),
                _drawerItem(
                  icon: Icons.settings_outlined,
                  text: 'Configuración',
                  index: 2,
                ),

                const Spacer(),

                const Divider(),

                _drawerItem(
                  icon: Icons.person_2_outlined,
                  text: 'Actualizar usuario',
                  index: -1,
                ),

                _drawerItem(
                  icon: Icons.logout,
                  text: 'Cerrar sesión',
                  index: -2,
                  isLogout: true,
                ),

                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),

      body: _pages[_selectedIndex],
    );
  }

  /// ITEM DEL DRAWER
  Widget _drawerItem({
    required IconData icon,
    required String text,
    required int index,
    bool isLogout = false,
  }) {
    final isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isLogout
            ? Colors.red
            : isSelected
            ? const Color(0xFF1E3C72)
            : Colors.grey[700],
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isLogout
              ? Colors.red
              : isSelected
              ? const Color(0xFF1E3C72)
              : Colors.grey[800],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {
        Navigator.pop(context);

        if (!isLogout) {
          setState(() {
            _selectedIndex = index;
          });
        } else {
          _bloc?.add(LogoutHomeEvent());
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
            (_) => false,
          );
        }
      },
    );
  }
}
