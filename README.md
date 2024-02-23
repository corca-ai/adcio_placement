# adcio_placement
[![pub package](https://img.shields.io/pub/v/adcio_placement.svg)](https://pub.dev/packages/adcio_placement)

A Flutter plugin that provides a ADCIO placement service. It smartly predicts products with high click or purchase probabilities from the client's products and returns the product information.

To learn more about ADCIO, please visit the [ADCIO website](https://www.adcio.ai/)

## Getting Started
To get started with ADCIO account, please register [ADCIO account](https://app.adcio.ai/en/)

## Usage
There is a simple use example:

```dart
import 'package:adcio_placement/adcio_placement.dart';

adcioSuggest(
  placementId: '...',
).then((result) {
  AdcioSuggestionRawData adcioSuggestionRaw = result;
});
```
To learn more about usage of plugin, please visit the [adcio_placement Usage documentation.](https://docs.adcio.ai/en/sdk/flutter/suggestions)

## Issues and feedback
If the plugin has issues, bugs, feedback, Please contact <app@corca.ai>.
