/*
Factory Pattern Implementation in Dart
Example: Cloud Storage Provider

Problem without factory: the client needs to know which concrete class to
instantiate and how to construct it — coupling the caller to implementation details.

Factory centralizes construction so the caller only depends on the interface.

* Caller is decoupled — main only references CloudStorage and CloudStorageFactory, never S3Storage or GCSStorage directly

* Construction complexity is hidden — each provider needs different config keys; the factory handles that mapping

* Config-driven — the concrete type is determined at runtime from a map, which mirrors how you'd read from env vars or a config file in a real app

* Adding a new provider (Backblaze, Cloudflare R2) requires zero changes to main — just add a new class and a switch case
*/

// Product interface
abstract class CloudStorage {
  Future<void> upload(String fileName, List<int> bytes);
  Future<List<int>> download(String fileName);
  String get providerName;
}

// Concrete products
class S3Storage implements CloudStorage {
  final String bucket;
  final String region;

  S3Storage({required this.bucket, required this.region});

  @override
  Future<void> upload(String fileName, List<int> bytes) async =>
      print('[$providerName] Uploading $fileName to $bucket ($region)');

  @override
  Future<List<int>> download(String fileName) async {
    print('[$providerName] Downloading $fileName from $bucket ($region)');
    return [];
  }

  @override
  String get providerName => 'AWS S3';
}

class GCSStorage implements CloudStorage {
  final String projectId;

  GCSStorage({required this.projectId});

  @override
  Future<void> upload(String fileName, List<int> bytes) async =>
      print('[$providerName] Uploading $fileName to project $projectId');

  @override
  Future<List<int>> download(String fileName) async {
    print('[$providerName] Downloading $fileName from project $projectId');
    return [];
  }

  @override
  String get providerName => 'Google Cloud Storage';
}

class AzureStorage implements CloudStorage {
  final String connectionString;

  AzureStorage({required this.connectionString});

  @override
  Future<void> upload(String fileName, List<int> bytes) async =>
      print('[$providerName] Uploading $fileName');

  @override
  Future<List<int>> download(String fileName) async {
    print('[$providerName] Downloading $fileName');
    return [];
  }

  @override
  String get providerName => 'Azure Blob Storage';
}

// Factory
class CloudStorageFactory {
  static CloudStorage create(Map<String, String> config) {
    final provider = config['provider'] ?? '';

    return switch (provider) {
      'aws' => S3Storage(
        bucket: config['bucket'] ?? '',
        region: config['region'] ?? 'us-east-1',
      ),
      'gcs' => GCSStorage(projectId: config['project_id'] ?? ''),
      'azure' => AzureStorage(
        connectionString: config['connection_string'] ?? '',
      ),
      _ => throw ArgumentError('Unknown provider: $provider'),
    };
  }
}

void main() async {
  // Caller only knows about CloudStorage — not S3Storage, GCSStorage, etc.
  final storages = [
    CloudStorageFactory.create({
      'provider': 'aws',
      'bucket': 'my-bucket',
      'region': 'eu-west-1',
    }),
    CloudStorageFactory.create({
      'provider': 'gcs',
      'project_id': 'my-gcp-project',
    }),
    CloudStorageFactory.create({
      'provider': 'azure',
      'connection_string': 'DefaultEndpointsProtocol=https;...',
    }),
  ];

  for (final storage in storages) {
    await storage.upload('data.csv', []);
  }
}
