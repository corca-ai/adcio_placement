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
    adcioSuggest(
      placementId: '9f9f9b00-dc16-41c7-a5cd-f9a788d3d481',
      baseUrl: 'https://api-dev.adcio.ai',
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
      ),
      body: rawData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) => Card(
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
