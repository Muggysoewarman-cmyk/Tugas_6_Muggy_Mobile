import 'package:flutter/material.dart';
import 'detailpage.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> travelData;

  const HomePage({super.key, required this.travelData});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Katalog Wisata'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.view_agenda), text: 'List View'),
              Tab(icon: Icon(Icons.grid_view), text: 'Grid View'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildListView(),
            buildGridView(),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          nama: item['nama']!,
          lokasi: item['lokasi']!,
          gambar: item['gambar']!,
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: travelData.length,
      itemBuilder: (context, index) {
        final item = travelData[index];
        return Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: item['nama']!,
                child: Image.network(
                  item['gambar']!,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  errorBuilder: (c, e, s) => const SizedBox(
                    width: 80,
                    height: 80,
                    child: Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            title: Text(item['nama']!),
            subtitle: Text(item['lokasi']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openDetail(context, item),
          ),
        );
      },
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: travelData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = travelData[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => _openDetail(context, item),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item['gambar']!,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      const Center(child: Icon(Icons.broken_image)),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Text(
                    item['nama']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}