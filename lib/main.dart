import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}


class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Usuário',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const TelaLogin(),
    );
  }
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool ocultarSenha = true;

  
  final String usuarioCorreto = 'admin';
  final String senhaCorreta = '1234';

  void fazerLogin() {
    String usuario = usuarioController.text;
    String senha = senhaController.text;

    // Verifica se os campos estão vazios
    if (usuario.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o usuário e a senha!'),
        ),
      );
    }
   
    else if (usuario == usuarioCorreto && senha == senhaCorreta) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaCadastro(
            nomeUsuario: usuario,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou senha incorretos!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    usuarioController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar centralizado
                const CircleAvatar(
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 70,
                  ),
                ),

                const SizedBox(height: 30),

                
                TextField(
                  controller: usuarioController,
                  decoration: const InputDecoration(
                    labelText: 'Nome de usuário',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 20),

                
                TextField(
                  controller: senhaController,
                  obscureText: ocultarSenha,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),

                    
                    suffixIcon: IconButton(
                      icon: Icon(
                        ocultarSenha
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          ocultarSenha = !ocultarSenha;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: fazerLogin,
                    child: const Text('Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class TelaCadastro extends StatefulWidget {
  final String nomeUsuario;

  const TelaCadastro({
    super.key,
    required this.nomeUsuario,
  });

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController cursoController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController paisController = TextEditingController();

  void salvarDados() {
    String nome = nomeController.text;
    String endereco = enderecoController.text;
    String curso = cursoController.text;
    String cidade = cidadeController.text;
    String pais = paisController.text;

    
    if (nome.isEmpty ||
        endereco.isEmpty ||
        curso.isEmpty ||
        cidade.isEmpty ||
        pais.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos!'),
        ),
      );

      return;
    }

    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dados cadastrados'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome: $nome'),
              const SizedBox(height: 8),

              Text('Endereço: $endereco'),
              const SizedBox(height: 8),

              Text('Curso: $curso'),
              const SizedBox(height: 8),

              Text('Cidade: $cidade'),
              const SizedBox(height: 8),

              Text('País: $pais'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void voltarLogin() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nomeController.dispose();
    enderecoController.dispose();
    cursoController.dispose();
    cidadeController.dispose();
    paisController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Mensagem de boas-vindas
            Text(
              'Bem-vindo ${widget.nomeUsuario}!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            CampoCadastro(
              controller: nomeController,
              texto: 'Nome',
              icone: Icons.person,
            ),

            const SizedBox(height: 15),

            CampoCadastro(
              controller: enderecoController,
              texto: 'Endereço',
              icone: Icons.home,
            ),

            const SizedBox(height: 15),

            CampoCadastro(
              controller: cursoController,
              texto: 'Curso',
              icone: Icons.school,
            ),

            const SizedBox(height: 15),

            CampoCadastro(
              controller: cidadeController,
              texto: 'Cidade',
              icone: Icons.location_city,
            ),

            const SizedBox(height: 15),

            CampoCadastro(
              controller: paisController,
              texto: 'País',
              icone: Icons.public,
            ),

            const SizedBox(height: 30),

            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: salvarDados,
                    child: const Text('Salvar'),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: ElevatedButton(
                    onPressed: voltarLogin,
                    child: const Text('Voltar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class CampoCadastro extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final IconData icone;

  const CampoCadastro({
    super.key,
    required this.controller,
    required this.texto,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: texto,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icone),
      ),
    );
  }
}