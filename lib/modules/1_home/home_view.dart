import 'package:chambeape/model/Employers.dart';
import 'package:chambeape/model/Workers.dart';
import 'package:chambeape/modules/1_home/user_card_widget.dart';
import 'package:chambeape/modules/1_home/user_grid_widget.dart';
import 'package:chambeape/services/users/worker_service.dart';
import 'package:flutter/material.dart';
import 'package:chambeape/services/users/employer_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Employers>> futureEmployers;
  late Future<List<Workers>> futureWorkers;

  @override
  void initState() {
    super.initState();
    futureEmployers = getEmployers();
    futureWorkers = getWorkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ChambeaPe'),
          backgroundColor: Colors.amber.shade700,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FutureBuilder(
            future: Future.wait([futureEmployers, futureWorkers]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Employers> employers = snapshot.data![0];
                List<Workers> workers = snapshot.data![1];

                List<String> employerImageUrls = employers
                    .map((employer) => employer.profilePic)
                    .take(6)
                    .toList();

                List<String> workerImageUrls =
                    workers.map((worker) => worker.profilePic).take(6).toList();

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SearchWidget(
                        controller: TextEditingController(),
                        hintText: 'Buscar',
                        trailing: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.search))
                        ],
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Últimas Búsquedas',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      UserCardWidget(employers: employers),
                      Divider(
                        color: Colors.amber.shade700.withOpacity(0.2),
                        thickness: 3,
                      ),
                      UserGridWidget(
                          crossAxisCount: 3,
                          imageUrls: employerImageUrls,
                          title: 'Top Empleadores'),
                      UserGridWidget(
                          crossAxisCount: 3,
                          imageUrls: workerImageUrls,
                          title: 'Top Chambeadores'),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final List<IconButton> trailing;

  const SearchWidget({
    required this.controller,
    required this.hintText,
    required this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      padding: const EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          ...trailing,
        ],
      ),
    );
  }
}
