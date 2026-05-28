import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chatPage.dart';
import 'usuario.dart';

class Conversas extends StatefulWidget {
  const Conversas({super.key});

  @override
  State<Conversas> createState() => _Conversas();
}

class _Conversas extends State<Conversas> {
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(       
        body: Column(children: [Expanded(child: lista())])
    );
  }

  lista() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: supabase
        .from('conversas')
        .stream(primaryKey: ['id'])
        .order('update_at', ascending: false),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
      
      final conversas = snapshot.data!;
      final minhasConversas = conversas.where((conv) {
        return conv['usuario1'] == idUsuarioLogado || conv['usuario2'] ==  idUsuarioLogado;
      }).toList();

      if (minhasConversas.isEmpty) {
        return Center(child: Text('Nenhuma Conversa'));
      }

      return ListView.builder(
        itemCount: minhasConversas.length,
        itemBuilder: (context, index) {
          final conversa = minhasConversas[index];
            final outroId = conversa['usuario1'] == idUsuarioLogado ? conversa['usuario2'] : conversa['usuario1'];

            return FutureBuilder(
              future: supabase
                .from('usuarios')
                .select()
                .eq('id', outroId)
                .maybeSingle(), 
                
              builder: (context, userSnap) {
                if (!userSnap.hasData) {
                  return SizedBox();
                }

                final usuario = userSnap.data!;
                final data = DateTime.parse(conversa['update_at']).toLocal();
                return ListTile(leading: CircleAvatar(
                  radius: 28, backgroundImage: NetworkImage(usuario['foto'])),
                title: Text(usuario['nome'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(conversa['ultima_mensagem'],
                  maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: Text(data.toString().substring(11,16), style: TextStyle(fontSize: 12)),
                onTap: () => abreEnvioMensagem(usuario['id'], usuario['nome'], usuario['foto']));
              });
        });
      });
      
    }

    void abreEnvioMensagem(String id, String nome, String foto) {
      contatoID = id;
      contatoNome = nome;
      contatoFoto = foto;
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => ChatPage()));
  }
}
