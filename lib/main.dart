import 'package:app_chat/cadastro.dart';
import 'package:app_chat/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://rymyvwplnagzgfyliufn.supabase.co',
    anonKey: 'sb_publishable_zX5EyDMy3WUqTAjjKTNarg_rtuluZ4U'
  );
  runApp(const MaterialApp(title: 'Flutter', home: Login()));
}

    // app de chat DS3 Etec
    // RMs 231343 191035

// class MyHommePage extends StatefulWidget {
//   const MyHommePage({super.key});

//   @override
//   State<MyHommePage> createState() => _MyHommePageState();
// }

// class _MyHommePageState extends State<MyHommePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       appBar: AppBar(title: Text('Chat Etec'),),
//       body: Column(children: [],),
//     );
//   }
// }