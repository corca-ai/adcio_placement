#  adcio_placement

A Flutter plugin that provides a ADCIO placement service.  
It smartly predicts products with high click or purchase probabilities from the client's products and returns the product information.

|             | Android        | iOS   |
|-------------|----------------|-------|
| **Support** | SDK 19+  | all |

</br>

## Usage

### Installation

Add `adcio_placement` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/adcio_placement/install).

### Android

This plugin uses
[device_info_plus](https://pub.dev/packages/device_info_plus).   
In `android/app/build.gradle` you need to set `minSdkVersion` like this:

```groovy
android {
    defaultConfig {
        minSdkVersion 19
    }
}
```

### Sample Usage

get `adcioSuggest()` result:
```dart
...
class _HomePageState extends State<HomePage> {
  AdcioSuggestionRawData? rawData;

  @override
  void initState() {
    super.initState();

    ///
    /// call adcioSuggest() here
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
```