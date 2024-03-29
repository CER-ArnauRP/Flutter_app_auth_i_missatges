import 'package:app_auth_i_missatges/auth/servei_auth.dart';
import 'package:app_auth_i_missatges/pagines/pagina_configuracio.dart';
import 'package:flutter/material.dart';

class DrawerAplicacio extends StatelessWidget {
  const DrawerAplicacio({super.key});

  void logout() {
    final serveiAuth = ServeiAuth();
    serveiAuth.tancarSessio();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[800],
      child: Column(
        // Dues columnes i el "spaceBetween" per fer que l'última opció
        //    aparegui al final.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Logo.
              const DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),

              // Opció Inici.
              ListTile(
                title: const Text(
                  "PÀGINA D'INICI",
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              // Opció Configuració.
              ListTile(
                title: const Text(
                  "CONFIGURACIÓ",
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaginaConfiguracio(),
                    ),
                  );
                },
              ),
            ],
          ),
          // Opció Logout.
          ListTile(
            title: const Text(
              "TANCAR SESSIÓ",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onTap: logout,
          ),
        ],
      ),
    );
  }
}
