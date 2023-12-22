import 'package:flutter/material.dart';

class PageTeste extends StatefulWidget {
  const PageTeste({super.key});

  @override
  State<PageTeste> createState() => _PageTesteState();
}

int controle = 0;

class _PageTesteState extends State<PageTeste> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina de teste'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.amber.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controle++;
                      });
                    },
                    child: const Text('Adicionar um'),
                  ),
                ),
                                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if(controle>0){
                      setState(() {
                        controle--;
                      });

                      }
                    },
                    child: const Text('Retira um'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controle,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.blue.shade300,
                      child: const Text('adicionou mais um'),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
