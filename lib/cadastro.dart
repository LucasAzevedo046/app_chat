import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _Cadastro();
}

final supabase = Supabase.instance.client;
String? urlImagem;

class _Cadastro extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(title: Text('Chat Etec'),),     
        body: Column(children: [
          Text('\n'),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Image.asset("imagens/logo.png", height: 100, width: 100))),
            Padding(padding: EdgeInsets.all(15), child: caixaNome()),
            Padding(padding: EdgeInsets.all(15), child: caixaEmail()),
            Padding(padding: EdgeInsets.all(15), child: caixaSenha()),
            Padding(padding: EdgeInsets.all(15), child: caixaConfirma()),
            btnCadastrar()
	    ]));
  }

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  TextEditingController txtConfirma = TextEditingController();

  caixaNome() {
    return TextField(
      controller: txtNome,
      decoration: InputDecoration(
        labelText: 'Informe seu Nome',
        border: OutlineInputBorder()
      ));
  }

  caixaEmail() {
    return TextField(
      controller: txtEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Informe seu Email',
        border: OutlineInputBorder()
      ));
  }

  caixaSenha() {
    return TextField(
      controller: txtSenha,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Informe sua Senha',
        border: OutlineInputBorder()
      ));
  }

  caixaConfirma() {
    return TextField(
      controller: txtConfirma,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirme sua Senha',
        border: OutlineInputBorder()
      ));
  }

  void limpar() {
    txtNome.clear();
    txtEmail.clear();
    txtSenha.clear();
    txtConfirma.clear();
  }

  btnCadastrar() {
    return ElevatedButton(
      onPressed: () => mensagem(), 
      child: Text('Cadastrar'));
  }

  mensagem() {
    return showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog( 
        title: Text('Tipo de seleção de imagem'),
        content: Text('Selecione uma das opções'),
        actions: [botaoCamera(), botaoArquivo()],
      ));
  }

  Future uploadImagem(ImageSource source) async{
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    
    if (image == null) return;
    
    final bytes = await image.readAsBytes();
    
    final extension = path.extension(image.name);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}$extension';

    await supabase.storage.from('usuarios').uploadBinary(fileName, bytes);

    final imageUrl = supabase.storage.from('usuarios').getPublicUrl(fileName);
    urlImagem = imageUrl;
    Navigator.pop(context);
    adicionar(txtNome.text, txtSenha.text, txtConfirma.text);
  }

  Future<void> adicionar(String nome, String senha, String confirma) async {
    if (nome == "" || senha == "" || confirma == ""){
      return;
    }

    if (senha != confirma) {
      caixaMensagem('Senhas não conferem');
      limpar();
      return;
    }

    try {
      final response = await supabase.auth.signUp(
        email: txtEmail.text,
        password: txtSenha.text);

      final user = response.user;
      await supabase.from('alunos').insert({
        'id': user!.id,
        'nome': txtNome.text,
        'foto': urlImagem
      });  

      caixaMensagem('Usuário criado com sucesso!');
      limpar();
      Navigator.pop(context);
    } catch (e) {
      caixaMensagem(e.toString());
    }
  }

  caixaMensagem(String texto) {
    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('DS Etec'),
        content: Text('texto'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text('OK'))
        ],
      ));
  }

  botaoCamera() {
    return ElevatedButton(
      onPressed: () => uploadImagem(ImageSource.camera), 
      child: Text('Câmera'));
  }

  botaoArquivo() {
    return ElevatedButton(
      onPressed: () => uploadImagem(ImageSource.gallery), 
      child: Text('Galeria'));
  }
}
