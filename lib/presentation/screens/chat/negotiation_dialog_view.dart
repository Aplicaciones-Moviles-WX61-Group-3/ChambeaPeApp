import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/infrastructure/datasources/postsdb_datasource.dart';
import 'package:chambeape/infrastructure/models/negotiation.dart';
import 'package:chambeape/infrastructure/models/users.dart';
import 'package:chambeape/presentation/shared/enums/enum.dart';
import 'package:chambeape/presentation/shared/utils/custom_validators.dart';
import 'package:chambeape/services/negotiation/negotiation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NegotiationDialogView extends StatefulWidget {
  final Users? currentUser, otherUser;
  const NegotiationDialogView({super.key, required this.currentUser, required this.otherUser});

  @override
  State<NegotiationDialogView> createState() => _NegotiationDialogViewState();
}

class _NegotiationDialogViewState extends State<NegotiationDialogView> {
  final int _maxNegotiationStartDaysAhead = 30;
  final int _maxNegotiationEndDaysAhead = 365;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController remunerationController = TextEditingController();
  late String startDateString, endDateString;
  String? postDropdownValue = '';
  late Future<void> loadNegotiationDetails;
  late Negotiation negotiation;
  late List<Post> posts;
  late int employerId, workerId;
  bool negotiationExists = false;
  
  Future<void> _loadNegotiationDetails() async {
    if(widget.currentUser!.userRole == 'W'){
      employerId = widget.otherUser!.id ?? 0;
      workerId = widget.currentUser!.id ?? 0;
    } else {
      employerId = widget.currentUser!.id ?? 0;
      workerId = widget.otherUser!.id ?? 0;
    }
    print('Employer ID: $employerId, Worker ID: $workerId');
    negotiation = await NegotiationService().getNegotiationByWorkerIdAndEmployerId(
    workerId, employerId);
    posts = await PostsdbDatasource().getPostsByEmployerId(employerId);
    if(negotiation.id != 0){
      startDateController.text = DateFormat('dd/MM/yyyy').format(negotiation.startDay);
      endDateController.text = DateFormat('dd/MM/yyyy').format(negotiation.endDay);
      remunerationController.text = negotiation.salary.toString();
      postDropdownValue = posts.firstWhere((element) => element.id == negotiation.postId).title;
      negotiationExists = true;
    }
    else{
      postDropdownValue = posts[0].title;
      negotiationExists = false;
    }
    print('Negotiation: ${negotiation.id}'); 
    
  }

  Negotiation _parseNegotiation(){
    List<String> startDateParts =
                            startDateController.text.split('/');
                        int startDay = int.parse(startDateParts[0]);
                        int startMonth = int.parse(startDateParts[1]);
                        int startYear = int.parse(startDateParts[2]);

    List<String> endDateParts =
                          endDateController.text.split('/');
                      int endDay = int.parse(endDateParts[0]);
                      int endMonth = int.parse(endDateParts[1]);
                      int endYear = int.parse(endDateParts[2]);

    return Negotiation(
      id: negotiationExists ? negotiation.id : 0,
      workerId: workerId,
      employerId: employerId,
      startDay: DateTime(startYear, startMonth, startDay),
      endDay: DateTime(endYear, endMonth, endDay),
      salary: double.parse(remunerationController.text),
      postId: posts.firstWhere((element) => element.title == postDropdownValue).id ?? 0
    );
  }

  bool _createNegotiation() {
    if (_formKey.currentState!.validate()) {
      Negotiation parsedNegotiation = _parseNegotiation();
      NegotiationService().createNegotiation(parsedNegotiation);
      return true;
    }
    return false;
  }

  bool _updateNegotiation() {
    if (_formKey.currentState!.validate()) {
      Negotiation parsedNegotiation = _parseNegotiation();
      NegotiationService().updateNegotiation(parsedNegotiation);
      return true;
    }
    return false;
  }

  Future<void> _selectDate(TextEditingController dateController, {required DateType dateType}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: dateType == DateType.start ? 
        DateTime.now().add(Duration(days: _maxNegotiationStartDaysAhead)) : 
        DateTime.now().add(Duration(days: _maxNegotiationEndDaysAhead)),
      locale: const Locale('es', 'ES'),
    );

    if (pickedDate != null) {
      dateController.text =
        '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}';
    }
  }

  @override
  void initState() {
    super.initState();
    loadNegotiationDetails = _loadNegotiationDetails();
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    startDateController.text = formatter.format(DateTime.now());
    startDateString = startDateController.text;
    endDateString = endDateController.text;
    // startDateController.addListener(() {
    //   setState(() {
    //     startDateString = startDateController.text;
    //   });
    // });
    // endDateController.addListener(() {
    //   setState(() {
    //     endDateString = endDateController.text;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enviar negociación'),
      content: FutureBuilder<void>(
        future: _loadNegotiationDetails(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return const Center(child: Text('Error al cargar la información'));
          }
          else {
            return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            negotiation.id == 0 ? const Text('Crea una nueva negociación') : const Text('Ajusta la negociación existente'),
            const SizedBox(height: 15),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Publicación',
                    ),
                    value: postDropdownValue,
                    items:posts.map<DropdownMenuItem<String>>((Post value) {
                      return DropdownMenuItem<String>(
                        value: value.title,
                        child: Text(value.title),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      postDropdownValue = newValue;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, seleccione una publicación';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: startDateController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de inicio',
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    onTap: () {
                      _selectDate(startDateController, dateType: DateType.start);
                    },
                    validator: (value) => 
                    negotiationDateValidator(value, _maxNegotiationStartDaysAhead, dateType: DateType.start),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: endDateController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de fin',
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    onTap: () {
                      _selectDate(endDateController, dateType: DateType.end);
                    },
                    validator: (value) => 
                    negotiationDateValidator(value, _maxNegotiationStartDaysAhead, dateType: DateType.end),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: remunerationController,
                    decoration: const InputDecoration(
                      prefixText: 'S/ ',
                      labelText: 'Remuneración',
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                    ),
                    validator: (value) => remunerationValidator(value),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ]
                  ),
                ],
              ),
            ),
          ],
        );
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          child: const Text('Cancelar')
        ),
        TextButton(
          onPressed: () {
            bool formIsValid = negotiationExists ? _updateNegotiation() : _createNegotiation();
            if(formIsValid){
              Navigator.of(context).pop();
            }
          }, 
          child: const Text('Enviar')
        ),
      ]
    );
  }
}