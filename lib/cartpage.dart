import 'package:flutter/material.dart';

/// State keranjang global yang bisa diakses dari semua halaman.
final ValueNotifier<List<Map<String, String>>> cartItems =
    ValueNotifier<List<Map<String, String>>>([]);

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void _hapus(BuildContext context, int index) {
    final list = List<Map<String, String>>.from(cartItems.value);
    final removed = list.removeAt(index);
    cartItems.value = list;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed['nama']} dihapus dari keranjang'),
        action: SnackBarAction(
          label: 'Batal',
          onPressed: () {
            final restored = List<Map<String, String>>.from(cartItems.value);
            restored.insert(index.clamp(0, restored.length), removed);
            cartItems.value = restored;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: ValueListenableBuilder<List<Map<String, String>>>(
        valueListenable: cartItems,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return const Center(child: Text('Keranjang masih kosong'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item['gambar']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => const SizedBox(
                        width: 80,
                        height: 80,
                        child: Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  title: Text(item['nama']!),
                  subtitle: Text(item['lokasi']!),
                  trailing: TextButton.icon(
                    onPressed: () => _hapus(context, index),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      'Hapus',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}