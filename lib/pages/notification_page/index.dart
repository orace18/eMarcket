import 'package:easy_market_client/pages/home_page/controllers/home_controller.dart';
import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:easy_market_client/pages/notification_page/controllers/notification_controller.dart';
import 'package:easy_market_client/pages/notification_page/models/commande_model.dart';
import 'package:get/get.dart';

import '../home_page/widgets/my_circle_bottom_navigation.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  HomeController _controller = HomeController();
  NotificationController controller = Get.put(NotificationController());
  List<Commande> commandeList = [];
  bool isLoading = false; 

  @override
  void initState() {
    super.initState();
    getAllCommande();
  }

  Future<void> getAllCommande() async {
    try {
      setState(() {
        isLoading = true; 
      });
      List<Commande> commandes = await controller.getAllCommande();
      setState(() {
        commandeList = commandes;
        isLoading = false; 
      });
    } catch (error) {
      print('Erreur lors de la récupération des commandes : $error');
      setState(() {
        isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Commandes'),
      ),
      body: isLoading 
          ? Center(
              child: CircularProgressIndicator(),
            )
          : commandeList.isEmpty
              ? Center(
                  child: Text("Aucune donnée disponible."),
                )
              : ListView.builder(
                  itemCount: commandeList.length,
                  itemBuilder: (context, index) {
                    final commande = commandeList[index];
                    return Card(
                      color: Color(0xFF120740),
                      elevation: 2.0,
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          '${commande.article.nom}',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Statut: ${commande.status}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
                            //Text('${commande.article.prix.toString()} FCFA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
                            Text('Quantité: ${commande.quantity.toString()}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: MyCircleBottomNavigation(
        itemIcons: _controller.itemIcons,
        centerText: 'Center',
        selectedIndex: 0,
        onItemPressed: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed('/home');
              break;
            case 1:
              Get.toNamed('/add');
              break;
            case 2:
              Get.toNamed('/notification');
              break;
            case 4:
              Get.toNamed('/profil');
              break;
          }
        },
      ),
    );
  }
}
