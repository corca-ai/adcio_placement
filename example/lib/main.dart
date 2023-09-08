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
                placementId: '9f9f9b00-dc16-41c7-a5cd-f9a788d3d481',
                baseUrl: 'https://api-dev.adcio.ai',
              ).then((value) {
                rawData = value;
                setState(() {});
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ///
              /// get session ID and device ID
              TextButton(
                onPressed: () {
                  final result = getSessionId();
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                    ),
                  );
                },
                child: const Text('Session ID'),
              ),
              TextButton(
                onPressed: () async {
                  final result = await getDeviceId();
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                    ),
                  );
                },
                child: const Text('device ID'),
              ),
            ],
          ),
        ),
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
