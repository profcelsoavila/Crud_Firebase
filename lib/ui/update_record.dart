import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.alunoKey}) : super(key: key);

  final String alunoKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  final userNomeController = TextEditingController();
  final userIdadeController = TextEditingController();
  final userMatriculaController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Alunos');
    getStudentData();
  }

  void getStudentData() async {
    DataSnapshot snapshot = await dbRef.child(widget.alunoKey).get();

    Map aluno = snapshot.value as Map;

    userNomeController.text = aluno['nome'];
    userIdadeController.text = aluno['idade'];
    userMatriculaController.text = aluno['matricula'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Atualizando dados no Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userNomeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  hintText: 'Digite seu nome',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userIdadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Idade',
                  hintText: 'Digite sua idade',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userMatriculaController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Magrícula',
                  hintText: 'Digite sua matrícula',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> alunos = {
                    'nome': userNomeController.text,
                    'idade': userIdadeController.text,
                    'matricula': userMatriculaController.text
                  };
                  setState(() {
                    dbRef
                        .child(widget.alunoKey)
                        .update(alunos)
                        .then((value) => {Navigator.pop(context)});
                  });
                },
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
                child: const Text('Atualizar dados'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
