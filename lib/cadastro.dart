import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

final supabase = Supabase.instance.client;
String? urlImagem;

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(       
        body: Column(children: [
		caixaNome(),
    caixaEmail(),
    caixaSenha(),
    caixaConfirma(),
    btnCadastro(),

	])
    );
  }


  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  TextEditingController txtConfirma = TextEditingController();

    caixaNome(){
      return TextField(
        controller: txtNome,
        decoration:  InputDecoration(
          labelText: 'Informe seu nome:',
          border: OutlineInputBorder(),
        ),
      );
    }

  caixaEmail(){
    return TextField(
      controller: txtEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Informe seu email:',
        border: OutlineInputBorder(),
      ),
    );
  }

   caixaSenha(){
      return TextField(
        controller: txtSenha,
        obscureText: true,
        decoration:  InputDecoration(
          labelText: 'Senha:',
          border: OutlineInputBorder(),
        ),
      );
    }

    
   caixaConfirma(){
      return TextField(
        controller: txtConfirma,
        obscureText: true,
        decoration:  InputDecoration(
          labelText: 'Confirme sua senha:',
          border: OutlineInputBorder(),
        ),
      );
    }

    btnCadastro(){
      return ElevatedButton(
        onPressed: () => mensagem(), 
        child: Text('Cadastrar'));
    }

    mensagem(){
     return showDialog(
      context: context, 
      builder: (BuildContext content) => AlertDialog(
          title: Text('Tipo de seleção de imagem'),
          content: Text('Selecione uma das opções'),
          actions: [btnCamera(), btnArquivo()],
      ), 
    );
  }

  ElevatedButton btnCamera(){
    return ElevatedButton(
      onPressed: () => uploadImagem(ImageSource.camera), 
      child: Text('Camera'));
  }

  ElevatedButton btnArquivo(){
    return ElevatedButton(
      onPressed: () => uploadImagem(ImageSource.gallery), 
      child: Text('Galeria'));
  }

  Future uploadImagem(ImageSource source ) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if(image == null)return;

    final bytes =  await image.readAsBytes();

    final extension = path.extension(image.name);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}$extension';

    await supabase.storage.from('usuarios').updateBinary(fileName, bytes);

    final imageUrl = supabase.storage.from('usuarios').getPublicUrl(fileName);
    urlImagem = imageUrl;
    Navigator.pop(context);
    adicionar(txtNome.text, txtSenha.text, txtConfirma.text);
  
  }

  void limpar(){
    setState(() {
      txtSenha.clear();
      txtNome.clear();
      txtConfirma.clear();
      txtEmail.clear();
    });
  }

  Future<void> buscar() async{
    final response = await supabase.from('alunos').select().order('nome');

    setState((){
        alunos = response;
    });
  }
  // Função para adicionar dados do aluno e curso
  Future<void> adicionar(String nome, String senha, String confirma) async{
   if (nome == "" || senha == "" || confirma == ""){
    return;
   }

   if(senha != confirma){
    caixaMensagem('Senhas não conferem');
    limpar();
    return;
   }

   try {
    final response = await supabase.auth.signUp(
      password: txtSenha.text,
      email: txtEmail.text);

      final user = response.user;
      await supabase.from('usuarios').insert({
        'id': user!.id,
        'nome': txtNome.text,
        'foto': urlImagem,
      });
      
      caixaMensagem('Usuario criado com sucesso!');
      limpar();
      Navigator.pop(context);
   }catch(e){
      caixaMensagem(e.toString());
   }

  }

}
