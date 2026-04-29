/*
Template Pattern is a behavioural design pattern that defines the skeleton of an algorithm in a base class, allowing subclasses to override specific steps of the algorithm without changing its overall structure.

Key points:

1. The base class provides a template method that outlines the algorithm.
2. Some steps in the algorithm are implemented in the base class, while others are defined as abstract or "hook" methods for subclasses to implement.
3. This pattern promotes code reuse and enforces a consistent algorithm structure, while allowing flexibility in individual steps.

Use cases:

1. When you have multiple classes with similar algorithms but some steps differ.
2. When you want to avoid code duplication and centralize the algorithm’s structure.
3. Example: In a data processing pipeline, the template method could define the steps: load data, process data, and save results. Subclasses can provide their own implementations for each step.
*/

abstract class DataParser<T> {
  Future<void> openFile(String filePath) async {
    print('Opening file: $filePath');
  }

  Future<void> closeFile(String filePath) async {
    print('Closing file: $filePath');
  }

  Future<T> parseData(); // Abstract method to be implemented by subclasses

  Future<T> parse(String filePath) async {
    await openFile(filePath);
    final parsedData = await parseData();
    await closeFile(filePath);

    return parsedData;
  }
}

class CSVParser extends DataParser<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> parseData() async {
    print('Parsing CSV data...');
    return {};
  }
}

class JSONParser extends DataParser<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> parseData() async {
    print('Parsing JSON data...');
    return {};
  }
}

void main() async {
  DataParser<Map<String, dynamic>> csvParser = CSVParser();
  await csvParser.parse('data.csv');

  print('---');

  DataParser<Map<String, dynamic>> jsonParser = JSONParser();
  await jsonParser.parse('data.json');
}
