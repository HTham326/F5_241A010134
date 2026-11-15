# LAB F5 – DANH SÁCH VÀ LƯỚI SẢN PHẨM

**Mã sinh viên:** 241A010134  
**Họ và tên:** Nguyễn Thị Hồng Thắm  
**Lớp:** CNTT – LTDD  
**Môn học:** Lập trình thiết bị di động

---

## 1. Giới thiệu

Ứng dụng Lab F5 được xây dựng bằng Flutter nhằm thực hành hiển thị danh sách và lưới sản phẩm. Ứng dụng sử dụng dữ liệu mẫu để minh họa cách xây dựng giao diện, quản lý danh sách và tương tác với các phần tử.

## 2. Công nghệ sử dụng

- Flutter
- Dart
- Material Design 3
- Android Studio
- Visual Studio Code (nếu sử dụng)

## 3. Chức năng chính

### 3.1. Danh sách sản phẩm

- Hiển thị sản phẩm bằng `ListView.builder`.
- Sử dụng `Card` và `ListTile` để trình bày thông tin.
- Hiển thị hình ảnh, tên, mô tả và giá sản phẩm.
- Thêm sản phẩm mới bằng `FloatingActionButton`.
- Vuốt sản phẩm sang trái để xóa bằng `Dismissible`.
- Hiển thị thông báo khi người dùng chọn hoặc xóa sản phẩm.
- Thông báo khi danh sách không còn sản phẩm.

### 3.2. Lưới sản phẩm

- Hiển thị sản phẩm bằng `GridView.builder`.
- Sử dụng `GridView` để trình bày hình ảnh và thông tin sản phẩm dạng lưới.
- Điều chỉnh khoảng cách và tỷ lệ hiển thị của từng ô.
- Sử dụng widget `AnhSanPham` để tái sử dụng thành phần hiển thị hình ảnh.

### 3.3. Chuyển đổi giao diện

- Sử dụng `NavigationBar` để chuyển đổi giữa hai tab:
  - Danh sách sản phẩm.
  - Album ảnh.

## 4. Bài tập nâng cao

### NC1 – Tìm kiếm sản phẩm

- Bổ sung ô tìm kiếm bằng `TextField`.
- Sử dụng `onChanged` để nhận từ khóa người dùng nhập.
- Sử dụng `where()` và `contains()` để lọc sản phẩm theo tên.
- Tìm kiếm không phân biệt chữ hoa và chữ thường.
- Hiển thị thông báo khi không tìm thấy sản phẩm.
- Bổ sung nút xóa từ khóa để khôi phục danh sách ban đầu.

### NC4 – Tối ưu lưới sản phẩm Responsive

- Sử dụng `SliverGridDelegateWithMaxCrossAxisExtent`.
- Thiết lập chiều rộng tối đa của mỗi ô lưới là 180 logical pixels.
- Tự động điều chỉnh số cột dựa trên chiều rộng màn hình.
- Kiểm tra giao diện khi thay đổi hướng màn hình.

## 5. Cấu trúc dự án

```text
f5_danhsach/
├── assets/
│   └── images/
│       ├── p1.jpg
│       ├── p2.jpg
│       ├── p3.jpg
│       ├── p4.jpg
│       ├── p5.jpg
│       └── p6.jpg
├── lib/
│   └── main.dart
├── test/
├── android/
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
└── README.md
```

## 6. Hướng dẫn cài đặt và chạy ứng dụng

### Bước 1: Lấy mã nguồn

```bash
git clone https://github.com/HTham326/F5_241A010134.git
```

### Bước 2: Truy cập thư mục dự án

```bash
cd f5_danhsach
```

### Bước 3: Cài đặt thư viện

```bash
flutter pub get
```

### Bước 4: Kiểm tra mã nguồn

```bash
flutter analyze
```

### Bước 5: Chạy ứng dụng

```bash
flutter run
```

## 7. Kiểm thử

Các nội dung đã kiểm tra:

- Hiển thị danh sách sản phẩm.
- Hiển thị hình ảnh và thông tin sản phẩm.
- Thêm sản phẩm mới.
- Vuốt để xóa sản phẩm.
- Hiển thị trạng thái danh sách trống.
- Chuyển đổi giữa giao diện danh sách và lưới.
- Tìm kiếm sản phẩm theo tên.
- Xử lý trường hợp không tìm thấy sản phẩm.
- Xóa từ khóa tìm kiếm.
- Điều chỉnh số cột của lưới khi thay đổi chiều rộng màn hình.
- Kiểm tra mã nguồn bằng `flutter analyze`.

**Kết quả phân tích mã nguồn:** `No issues found!`

## 8. Lịch sử Git

| Commit | Nội dung |
|---|---|
| `7d977a3` | F5: Khởi tạo app |
| `a9f7a1a` | F5 - NC1: Thêm chức năng tìm kiếm sản phẩm |
| `4083818` | F5: NC4 - Tối ưu lưới sản phẩm responsive |

## 9. Kết luận

Qua bài thực hành Lab F5, em đã hiểu và vận dụng được các widget Flutter dùng để hiển thị dữ liệu dạng danh sách và dạng lưới.

Ngoài ra, em đã thực hiện được chức năng tìm kiếm sản phẩm, thêm và xóa phần tử trong danh sách, cũng như tối ưu giao diện lưới để thích ứng với kích thước màn hình.

Bài thực hành giúp củng cố kiến thức về `ListView.builder`, `GridView.builder`, `Dismissible`, `TextField`, `setState()` và cách tổ chức các widget có khả năng tái sử dụng.