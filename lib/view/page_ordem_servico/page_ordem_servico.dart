import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:anim_search_bar/anim_search_bar.dart';


class PageOrdemDeServico extends StatefulWidget {
  const PageOrdemDeServico({super.key});

  @override
  State<PageOrdemDeServico> createState() => _PageOrdemDeServicoState();
}

class _PageOrdemDeServicoState extends State<PageOrdemDeServico> {
  bool controle = true;
  @override
  Widget build(BuildContext context) {
    TextEditingController _clientSerach = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cliente'),
                Align(
                  alignment: Alignment.center,
                  child: AnimSearchBar(
                    rtl: true,
                    color: Colors.grey.shade200,
                    boxShadow: false,
                    width: 400,
                    textController: _clientSerach,
                    
                    onSuffixTap: () {
                      print('cliquei...');
                    },
                    onSubmitted: (p0) {
                            print('cliquei...2');
                    },
                  ),
                ),
                // const Text('Cliente'),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.search),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                color: Colors.grey.shade200,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Cliente'),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
