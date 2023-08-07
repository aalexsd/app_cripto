import 'package:app_cripto/Pages/moedas_detalhes_page.dart';
import 'package:app_cripto/Repositories/favoritas_repository.dart';
import 'package:app_cripto/Repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../ Models/moeda.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = Moedarepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  customAppBar() {
    if (selecionadas.isEmpty) {
      return const SliverAppBar(
        title: Text('CriptoMoedas'),
        snap: true,
        floating: true,
      );
    } else {
      return SliverAppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                selecionadas = [];
              });
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text('${selecionadas.length} selecionadas'),
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MoedasDetalhes(moeda: moeda)));
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // favoritas = Provider.of<FavoritaRepository>(context);
    favoritas = context.watch<FavoritasRepository>();

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [
          customAppBar(),
        ],
        body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            return ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              leading: (selecionadas.contains(tabela[moeda]))
                  ? const CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      width: 40, child: Image.asset(tabela[moeda].icone)),
              title: Row(
                children: [
                  Text(
                    tabela[moeda].nome,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (favoritas.lista.contains(tabela[moeda]))
                    const Icon(
                      Icons.circle,
                      color: Colors.amber,
                      size: 8,
                    )
                ],
              ),
              trailing: Text(real.format(tabela[moeda].preco)),
              selected: selecionadas.contains(tabela[moeda]),
              selectedTileColor: Colors.indigo[50],
              onTap: () {
                if (selecionadas.isEmpty) {
                  mostrarDetalhes(tabela[moeda]);
                } else {
                  setState(() {
                    (selecionadas.contains(tabela[moeda]))
                        ? selecionadas.remove(tabela[moeda])
                        : selecionadas.add(tabela[moeda]);
                  });
                }
              },
              onLongPress: () {
                setState(() {
                  (selecionadas.contains(tabela[moeda]))
                      ? selecionadas.remove(tabela[moeda])
                      : selecionadas.add(tabela[moeda]);
                });
              },
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(
            thickness: 1.0,
          ),
          itemCount: tabela.length,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              },
              icon: const Icon(Icons.star),
              label: const Text(
                'FAVORITAR',
                style: TextStyle(letterSpacing: 0, fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }
}
