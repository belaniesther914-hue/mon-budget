import 'package:flutter/material.dart';

void main() {
  runApp(MonApp());
}

class MonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Budget',
      theme: ThemeData(primarySwatch: Colors.green),
      home: PageBudget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Depense {
  String nom;
  double montant;
  Depense(this.nom, this.montant);
}

class PageBudget extends StatefulWidget {
  @override
  _PageBudgetState createState() => _PageBudgetState();
}

class _PageBudgetState extends State<PageBudget> {
  List<Depense> depenses = [];
  TextEditingController nomController = TextEditingController();
  TextEditingController montantController = TextEditingController();

  double get total {
    double somme = 0;
    for (var d in depenses) {
      somme += d.montant;
    }
    return somme;
  }

  void ajouterDepense() {
    if (nomController.text.isNotEmpty && montantController.text.isNotEmpty) {
      setState(() {
        depenses.add(
          Depense(nomController.text, double.tryParse(montantController.text) ?? 0),
        );
        nomController.clear();
        montantController.clear();
      });
    }
  }

  void supprimerDepense(int index) {
    setState(() {
      depenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Budget'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.green[100],
            child: Column(
              children: [
                Text('Total dépensé', style: TextStyle(fontSize: 16)),
                SizedBox(height: 5),
                Text(
                  '${total.toStringAsFixed(0)} FC',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[800]),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: nomController,
                  decoration: InputDecoration(
                    hintText: 'Ex: Pain, Transport...',
                    border: OutlineInputBorder(),
                    labelText: 'Nom de la dépense',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: montantController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Ex: 5000',
                    border: OutlineInputBorder(),
                    labelText: 'Montant en FC',
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ajouterDepense,
                    child: Text('+ Ajouter dépense'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: depenses.isEmpty
                ? Center(child: Text('Aucune dépense pour le moment'))
                : ListView.builder(
                    itemCount: depenses.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.money, color: Colors.green),
                        title: Text(depenses[index].nom),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${depenses[index].montant.toStringAsFixed(0)} FC',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => supprimerDepense(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}