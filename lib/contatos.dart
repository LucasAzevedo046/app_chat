import 'package:flutter/material.dart';
import 'chatPage.dart';
import 'usuario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Contatos extends StatefulWidget {
  const Contatos({super.key});

  @override
  State<Contatos> createState() => _ContatosState();
}

List usuarios = [];
final supabase = Supabase.instance.client;

class _ContatosState extends State<Contatos> {
  @override
 void initState(){
  super.initState();
  buscar();
 }

 Future<void> buscar() async{
  final response = await supabase
  .from('usuarios')
  .select()
  .neq('id', idUsuarioLogado)
  .order('nome', ascending: true);
  setState((){
    usuarios = response;
  });
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(children: [Expanded(child: lista())]),
    );
    
  }

  ListView lista(){
    return ListView.builder(
      itemCount: usuarios.length,
      itemBuilder: (context, index){
        final usuario = usuarios[index];
        return ListTile(
          onTap: () => abreEnvioMensagem(usuario['id'], usuario['nome'], usuario['foto']),
          leading: CircleAvatar(backgroundImage: NetworkImage(usuario['foto'])),
          title: Text(usuario['nome'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
        );
      },
    );
  }

  void abreEnvioMensagem(String id, String nome, String foto){
    contatoID = id;
    contatoNome = nome;
    contatoFoto = foto;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatPage()),
    );
  }

 
}
