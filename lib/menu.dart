import 'package:flutter/material.dart';
import 'usuario.dart';
import 'conversas.dart';
import 'contatos.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Chat Etec'),
            CircleAvatar(backgroundImage: NetworkImage(fotoUsuarioLogado)),
          ]),
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.contacts), text: "Contatos"),
            Tab(icon: Icon(Icons.message), text: "Mensagens"),
          ]
        ),   
      ),  
<<<<<<< HEAD
      body: TabBarView(children: [Contatos(),Conversas()]),
=======
      body: TabBarView(children: [Contatos(), Conversas()]),
>>>>>>> 0248be67e82998aeb270202339006f048a103a20
	  ),
    );
  }
}