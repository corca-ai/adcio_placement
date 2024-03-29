// ignore_for_file: use_build_context_synchronously

import 'package:adcio_placement/adcio_placement.dart';
import 'package:example/model/user.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdcioSuggestionRawData? rawData;
  late final User currenctUser;
  late final String currentLocation;

  @override
  void initState() {
    super.initState();

    currenctUser = User(
      id: const Uuid().v4(),
      name: 'adcio',
      birthDate: DateTime(2000, 2, 20),
      gender: Gender.male,
    );

    currentLocation = 'Seoul, Korea';

    suggest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADCIO placement demo'),
        actions: [
          IconButton(
            onPressed: () {
              suggest();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: rawData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) => Card(
                ///
                /// used suggestion data
                child: ListTile(
                  onTap: () => debugPrint(
                    'Product ID for your service: ${rawData!.suggestions[index].product!.idOnStore}',
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      rawData!.suggestions[index].product!.image,
                    ),
                  ),
                  title: Text(
                    rawData!.suggestions[index].product!.name,
                  ),
                ),
              ),
              itemCount: rawData!.suggestions.length,
            ),
    );
  }

  ///
  /// call adcioSuggest() here
  void suggest() {
    adcioCreateSuggestion(
      placementId: '67592c00-a230-4c31-902e-82ae4fe71866',
      customerId: currenctUser.id,
      birthYear: currenctUser.birthDate.year,
      gender: currenctUser.gender.name,
      area: currentLocation,
    ).then((value) {
      rawData = value;
      setState(() {});
    });
  }
}
