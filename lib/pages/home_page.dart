import 'package:flutter/material.dart';
import 'package:lista_tarefas_file_2024_2/repositories/repositorio.dart';

import '../model/tarefa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Tarefa> tarefas=[];
  TextEditingController controllerTarefa = new TextEditingController();

  @override
  void initState() {
    Repositorio.recuperarTudo().then((dados){
      setState(() {
        tarefas=dados;
        print(tarefas);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextField(
                controller: controllerTarefa,
                decoration: InputDecoration(label: Text("Nova tarefa")),)),
              IconButton(onPressed: () {
                setState(() {
                  Tarefa tarefa = new Tarefa(nome: controllerTarefa.text, realizado: false);
                  tarefas.add(tarefa);
                });
                Repositorio.salvarTudo(tarefas);
                controllerTarefa.clear();
              }, icon: Icon(Icons.add))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: _construtorLista,
              itemCount: tarefas.length,),
          ),
        ],
      ),
    );
  }

  Widget _construtorLista(BuildContext context, int index) {
    return CheckboxListTile(
      title: Text(tarefas[index].nome),
      value: tarefas[index].realizado,
      onChanged: (checked) {
        Repositorio.salvarTudo(tarefas);
      },
      secondary: tarefas[index].realizado ?
      Icon(Icons.verified):
      Icon(Icons.error),
      );
  }
}


