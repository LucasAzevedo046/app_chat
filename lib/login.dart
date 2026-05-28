import 'package:flutter/material.dart';
import 'dart:io';
import 'cadastro.dart';
import 'menu.dart';
import 'usuario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

<<<<<<< HEAD
final supabase = Supabase.instance.client;
=======
>>>>>>> 0248be67e82998aeb270202339006f048a103a20

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

final supabase = Supabase.instance.client;


class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(       
<<<<<<< HEAD
        body: Column(children: [Text('\n\n\n'),
              Material(borderRadius: BorderRadius.all(Radius.circular(20.0)),
                elevation: 10,
                child: Padding(padding: EdgeInsets.all(20.0),
                child: Image.asset("imagens/logo.png", height: 200, width: 200))),
              Padding(padding: EdgeInsets.all(15), child: caixaEmail()),
              Padding(padding: EdgeInsets.all(15), child: caixaSenha()),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [btnEntrar(), btnSair()]),
              textoCadastro()]
        ),
    );
  }

        TextEditingController txtEmail = TextEditingController();
        TextEditingController txtSenha = TextEditingController();

  caixaEmail(){
  return TextField(
    controller: txtEmail,
    decoration: InputDecoration(
      labelText: 'Informe seu Email: ',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.email)
    ));
  }

  caixaSenha(){
  return TextField(
    controller: txtSenha,
    obscureText: true,
    decoration: InputDecoration(
      labelText: 'Senha: ',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.email)
    ));
  }

  textoCadastro(){
  return TextButton(
    onPressed: () => Navigator.push(context,
    MaterialPageRoute(builder: (context) => Cadastro())), 
    child: Text('Não tem login? CLique aqui para se cadastrar'));
  }

  btnEntrar(){
  return ElevatedButton(
    onPressed: () => login(txtEmail.text, txtSenha.text), 
    child: Text('Entrar'));
  }

  btnSair(){
  return ElevatedButton(
    onPressed: () => exit(0), 
    child: Text('Fechar'));
  }

    Future login (String email, String senha) async {
  if (email == "" || senha == "") {return;}

  try {
    final response = await supabase.auth.signInWithPassword( // signInWithPassword é um autenticador para verificar se há um usuario cadastrado
      email: email,
      password: senha,
      );

    if (response.user != null) {
      final userId = supabase.auth.currentUser!.id;
      final usuarioLogado = await supabase
                          .from('usuarios')
                          .select()
                          .eq('id', userId)
                          .single();
      fotoUsuarioLogado = usuarioLogado['foto'];
      idUsuarioLogado =  usuarioLogado['id'];
      nomeUsuarioLogado = usuarioLogado['nome'];
      limpar();
      abreMenu();
    }else{
      caixaMensagem('senha inválida');
      limpar();
    }

    }catch (e){ // (e) é abreviação de "erro"
    caixaMensagem(e.toString());
  } }

  void abreMenu(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));
  }
  caixaMensagem(String texto){
=======
        body: Column(children: [
          Text('\n\n\n'),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Image.asset("imagens/logo.png", height: 100, width: 100))),
            Padding(padding: EdgeInsets.all(15), child: caixaEmail()),
            Padding(padding: EdgeInsets.all(15), child: caixaSenha()),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [botaoEntrar(), botaoSair()],),
            textoCadastro()])
    );
  }

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  TextField caixaEmail() {
    return TextField(
      controller: txtEmail,
      decoration: InputDecoration(
        labelText: 'Informe seu Email',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.mail)
      ));
  }

  TextField caixaSenha() {
    return TextField(
      controller: txtSenha,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Informe sua Senha',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock)
      ));
  }

  TextButton textoCadastro() {
    return TextButton(
      onPressed: () => Navigator.push(context,
      MaterialPageRoute(builder: (context) => Cadastro())),
      child: Text('Não tem login? Clique aqui para se cadastrar'));
  }

  ElevatedButton botaoSair() {
    return ElevatedButton(
      onPressed: () => exit(0), child: Text('Fechar'));
  }

  ElevatedButton botaoEntrar() {
    return ElevatedButton(
      onPressed: () => login(txtEmail.text, txtSenha.text), child: Text('Entrar'));
  }

  Future login(String email, String senha) async {
    if (email == "" || senha == "") {return;} 

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email, 
        password: senha,
      );

      if (response.user != null) {
        final userId = supabase.auth.currentUser!.id;
        final usuarioLogado = await supabase
          .from('usuarios')
          .select()
          .eq('id', userId)
          .single();
        fotoUsuarioLogado = usuarioLogado['foto'];
        idUsuarioLogado = usuarioLogado['id'];
        nomeUsuarioLogado = usuarioLogado['nome'];
        limpar();
        abreMenu();
      } else {
        caixaMensagem('Senha inválida');
        limpar();
      }

    } catch (e) {
      caixaMensagem(e.toString());
    }
  }

  void abreMenu() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));
  }

  caixaMensagem(String texto) {
>>>>>>> 0248be67e82998aeb270202339006f048a103a20
    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('DS Etec'),
<<<<<<< HEAD
        content:  Text(texto),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text("OK")),
        ],
      ),
    );
  }

  void limpar(){
=======
        content: Text(texto),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text('OK'))
        ],
      ));
  }
  
  void limpar() {
>>>>>>> 0248be67e82998aeb270202339006f048a103a20
    txtEmail.clear();
    txtSenha.clear();
  }
}