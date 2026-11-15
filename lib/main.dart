import 'package:flutter/material.dart';
 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F5_241A010134',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0468D7)),
      ),
      home: const HomePage(),
    );
  }
}
 
// ===================================================================
// MODEL – tách dữ liệu ra khỏi giao diện
// ===================================================================
class SanPham {
  final String ten;
  final String moTa;
  final int gia; // đồng
  final String anh; // đường dẫn asset
 
  const SanPham({
    required this.ten,
    required this.moTa,
    required this.gia,
    required this.anh,
  });
}
 
/// "Cơ sở dữ liệu" tạm thời. Ở các lab sau sẽ thay bằng API hoặc SQLite.
final List<SanPham> duLieuMau = [
  const SanPham(
      ten: 'Gấu bông Capybara',
      moTa: 'Chất liệu lông mềm, tạo hình Capybara ôm quả cam dễ thương',
      gia: 180000,
      anh: 'assets/images/p1.jpg'),
  const SanPham(
      ten: 'Tai nghe chụp tai',
      moTa: 'Thiết kế over-ear, màu trắng',
      gia: 250000,
      anh: 'assets/images/p2.jpg'),
  const SanPham(
      ten: 'Bàn phím cơ RGB',
      moTa: 'Thiết kế màu trắng, đèn LED nhiều màu sắc',
      gia: 750000,
      anh: 'assets/images/p3.jpg'),
  const SanPham(
      ten: 'Đồng hồ thông minh',
      moTa: 'Màn hình cảm ứng, dây đeo silicon màu đen',
      gia: 1000000,
      anh: 'assets/images/p4.jpg'),
  const SanPham(
      ten: 'Túi tote mèo dễ thương',
      moTa: 'Chất liệu vải canvas, in hình mèo con',
      gia: 55000,
      anh: 'assets/images/p5.jpg'),
  const SanPham(
      ten: 'Bình giữ nhiệt màu tím',
      moTa: 'Thiết kế nắp bật, kiểu dáng hiện đại',
      gia: 95000,
      anh: 'assets/images/p6.jpg'),
];
 
/// Định dạng 180000 → "180.000 đ" (không cần thư viện ngoài).
String dinhDangGia(int gia) {
  final s = gia.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return '${buf.toString()} đ';
}
 
// ===================================================================
// KHUNG CHÍNH – 2 tab
// ===================================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  int _tab = 0;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tab == 0 ? 'Danh sách sản phẩm' : 'Album ảnh')),
      body: _tab == 0 ? const ProductListTab() : const AlbumTab(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Danh sách'),
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Lưới'),
        ],
      ),
    );
  }
}
 
// ===================================================================
// TAB 1 – ListView.builder + Card + Dismissible
// ===================================================================
class ProductListTab extends StatefulWidget {
  const ProductListTab({super.key});
 
  @override
  State<ProductListTab> createState() => _ProductListTabState();
}
 
class _ProductListTabState extends State<ProductListTab> {
  // Tạo bản sao để có thể thêm/xóa mà không đụng vào dữ liệu gốc
  final List<SanPham> _ds = List.of(duLieuMau);
  final TextEditingController _timKiemController = TextEditingController();
  
  String _tuKhoa = '';

  int _dem = 0; 
 
  void _them() {
    setState(() {
      _dem++;
      _ds.insert(
        0,
        SanPham(
          ten: 'Sản phẩm mới $_dem',
          moTa: 'Vừa được thêm lúc ${TimeOfDay.now().format(context)}',
          gia: 50000 * _dem,
          anh: 'assets/images/p1.jpg',
        ),
      );
    });
  }

  List<SanPham> get _dsTimKiem {
    if(_tuKhoa.isEmpty) {
      return _ds;
    }

    return _ds.where((sp) {
      return sp.ten.toLowerCase().contains(_tuKhoa.toLowerCase());
    }).toList();
  }
 
  @override
  Widget build(BuildContext context) {
    if (_ds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Danh sách trống'),
            TextButton(onPressed: _them, child: const Text('Thêm sản phẩm')),
          ],
        ),
      );
    }
 
    return Scaffold(
      // ListView.builder chỉ dựng những item đang nhìn thấy (lazy),
      // giống cách RecyclerView tái sử dụng ViewHolder bên Android.
      body: Column(
        children: [
          // Ô tìm kiếm sản phẩm
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _timKiemController,
              decoration: InputDecoration(
                hintText: 'Nhập tên sản phẩm cần tìm...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _tuKhoa.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _timKiemController.clear();
                        setState(() {
                          _tuKhoa = '';
                        });
                      },
                    )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _tuKhoa = value;
                });
              },
            ),
          ),

          // Danh sách sản phẩm sau khi tìm kiếm
          Expanded(
            child: _dsTimKiem.isEmpty
                ? const Center(
                  child: Text('Không tìm thấy sản phẩm phù hợp'),
                )
                : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _dsTimKiem.length,
                  itemBuilder: (context, index) {
                    final sp = _dsTimKiem[index];

                    return Dismissible(
                      key: ValueKey(sp.ten),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (_) {
                        setState(() {
                          _ds.remove(sp);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đã xoá ${sp.ten}'),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: AnhSanPham(
                            duongDan: sp.anh,
                            kichThuoc: 56,
                          ),
                          title: Text(
                            sp.ten,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            sp.moTa,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            dinhDangGia(sp.gia),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Bạn chọn: ${sp.ten}'),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: _them, child: const Icon(Icons.add)),
    );
  }
}
 
// ===================================================================
// TAB 2 – GridView.builder
// ===================================================================
class AlbumTab extends StatelessWidget {
  const AlbumTab({super.key});
 
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      // Số cột cố định. Muốn tự co giãn theo bề ngang màn hình thì dùng
      // SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 180).
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.78, // rộng / cao — sai số này là nguyên nhân tràn ô
      ),
      itemCount: duLieuMau.length,
      itemBuilder: (context, index) {
        final sp = duLieuMau[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: AnhSanPham(duongDan: sp.anh)),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sp.ten,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(dinhDangGia(sp.gia),
                        style: const TextStyle(color: Colors.blueGrey)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
 
// ===================================================================
// Widget ảnh dùng chung
// ===================================================================
class AnhSanPham extends StatelessWidget {
  final String duongDan;
  final double? kichThuoc;
 
  const AnhSanPham({super.key, required this.duongDan, this.kichThuoc});
 
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      duongDan,
      width: kichThuoc,
      height: kichThuoc,
      fit: BoxFit.cover,
      // Nếu chưa chép ảnh vào assets, app vẫn chạy và hiện ô xám thay vì đỏ lòm
      errorBuilder: (context, error, stackTrace) => Container(
        width: kichThuoc,
        height: kichThuoc,
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }
}