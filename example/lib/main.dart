// ignore_for_file: use_build_context_synchronously

import 'package:adcio_placement/adcio_placement.dart';
import 'package:flutter/material.dart';

void main() {
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

  @override
  void initState() {
    super.initState();

    ///
    /// call adcioSuggest() here
    adcioSuggest(
      placementId: '67592c00-a230-4c31-902e-82ae4fe71866',
    ).then((value) {
      rawData = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADCIO placement demo'),
        actions: [
          IconButton(
            onPressed: () {
              adcioSuggest(
                placementId: '67592c00-a230-4c31-902e-82ae4fe71866',
              ).then((value) {
                rawData = value;
                setState(() {});
              });
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
}
