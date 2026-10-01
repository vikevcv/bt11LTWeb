# BÀI GIẢI ĐỀ THI QUÁ TRÌNH 05 - LẬP TRÌNH WEB (HCMUTE)
**Mã đề:** Đề số 05  
**Giảng viên ra đề:** Nguyễn Hữu Trung  
**Thời gian:** 180 phút  
**Công nghệ:** Jakarta Servlet 6.0 + JPA (Hibernate 6) + JSP + MySQL + Apache Tomcat 10.1

---

## 📋 THÔNG TIN SINH VIÊN (HIỂN THỊ Ở FOOTER CÂU 1)
- **Họ và tên:** Hoa Vĩ Khang
- **MSSV:** 24110240
- **Mã đề:** Đề số 05

---

## 🚀 HƯỚNG DẪN CHẠY BÀI THI TRÊN SPRING TOOL SUITE (STS 4)

### 1. Khởi tạo Cơ sở dữ liệu MySQL
1. Mở MySQL Workbench hoặc DBeaver.
2. Mở file `database/schema.sql` trong dự án và nhấn **Execute** để tạo database `dtqt05` cùng toàn bộ 7 bảng và dữ liệu mẫu.
3. Kiểm tra mật khẩu MySQL trong file `src/main/resources/META-INF/persistence.xml` (mặc định: `root` / rỗng).

### 2. Import & Deploy vào Tomcat 10.1
1. Trong STS: **File** $\rightarrow$ **Import...** $\rightarrow$ **Maven** $\rightarrow$ **Existing Maven Projects** $\rightarrow$ Chọn thư mục `D:\HCMUTE\TLWeb\quatrinh\DTQT05` $\rightarrow$ Nhấn **Finish**.
2. Chuột phải vào project $\rightarrow$ **Properties** $\rightarrow$ **Deployment Assembly** $\rightarrow$ Đảm bảo đã có **Maven Dependencies** trỏ vào `WEB-INF/lib`.
3. Trong tab **Servers**: Chuột phải vào `Tomcat v10.1 Server` $\rightarrow$ **Add and Remove...** $\rightarrow$ Add `DTQT05` sang phải $\rightarrow$ Nhấn **Finish**.
4. Khởi động server (`Start` hoặc `Debug`).
5. Truy cập trình duyệt:
   ```text
   http://localhost:8080/DTQT05/
   ```

---

## 🧪 HƯỚNG DẪN CHẤM & KIỂM THỬ TỪNG CÂU HỎI

### Câu 1 (1.5 điểm): Cấu trúc 3 tầng & Sitemesh Decorator
- **Kiến trúc 3 tầng**:
  - *Presentation Layer*: Các Servlet Controller (`HomeController`, `AuthController`, `ProductPublicController`, `AdminCategoryController`, `AdminProductController`) + JSP Views.
  - *Business Layer*: Các Service (`UserService`, `CategoryService`, `ProductService`).
  - *Data Access Layer*: Các DAO (`UserDAO`, `SellerDAO`, `CategoryDAO`, `ProductDAO`) + JPA Hibernate.
- **Decorator 2 vai trò qua SiteMesh 3 (`user.jsp`, `admin.jsp`)**:
  - Giao diện người dùng (`user.jsp`): Menu gồm Trang Chủ, Sản phẩm, Đăng nhập. **Menu "Trang Quản Trị" chỉ xuất hiện khi đăng nhập tài khoản ADMIN**.
  - Phần Footer ở mọi trang hiển thị đầy đủ: **Họ tên, MSSV, Mã đề**.

---

### Câu 2 (1.5 điểm): Đăng ký kích hoạt OTP qua mail, Đăng nhập Session
1. **Kiểm tra Đăng ký & OTP**:
   - Truy cập: `http://localhost:8080/DTQT05/register`
   - Nhập thông tin đăng ký (username, email, password...).
   - Nhấn **Đăng ký** $\rightarrow$ Hệ thống tự động chuyển sang trang `/verify-otp`.
   - **Lấy mã OTP**: Mã OTP 6 chữ số sẽ được gửi qua email đồng thời **in rõ ràng trên cửa sổ Console của STS** (Ví dụ: `>>> MÃ OTP KÍCH HOẠT: [ 582914 ]`).
   - Nhập mã OTP vào trang `/verify-otp` $\rightarrow$ Tài khoản chuyển sang trạng thái kích hoạt (`status = 1`) và chuyển sang trang Đăng nhập.
2. **Kiểm tra Đăng nhập & Phân quyền chuyển hướng**:
   - **Tài khoản User**: `user01` / pass: `123456` $\rightarrow$ Tự động chuyển vào trang chủ User (`/home`).
   - **Tài khoản Seller**: `seller01` / pass: `123456` $\rightarrow$ Tự động chuyển vào trang chủ Seller (`/seller/home`).
   - **Tài khoản Admin**: `admin` / pass: `123456` $\rightarrow$ Menu xuất hiện thêm nút vàng **Trang Quản Trị** dẫn tới trang Admin (`/admin/categories`).
   - **Đăng xuất**: Bấm menu người dùng góc phải $\rightarrow$ Đăng xuất $\rightarrow$ Hủy Session an toàn.

---

### Câu 3 (2.0 điểm): Hiển thị sản phẩm gom theo từng Seller (Mã cửa hàng)
- Truy cập menu **Sản phẩm** hoặc URL: `http://localhost:8080/DTQT05/products`
- Hệ thống hiển thị các sản phẩm được gom nhóm theo từng Seller (Mã cửa hàng: 1 - Cửa hàng Thế Giới Công Nghệ, 2 - Nhà Sách Tri Thức...).
- Mỗi sản phẩm được format chuẩn theo khung đặc tả:
  - Cột trái: `[imageLink]`
  - Cột phải: `Tên sản phẩm`, `Mã sản phẩm`, `Danh mục`, `Giá`, `Amount`.

---

### Câu 4 (2.0 điểm): Trang chi tiết 01 sản phẩm
- Từ trang sản phẩm ở Câu 3, bấm vào tiêu đề sản phẩm bất kỳ (hoặc truy cập URL: `http://localhost:8080/DTQT05/product/detail?id=1`).
- Trang chi tiết hiển thị đầy đủ các trường theo đúng bảng đề bài:
  - `[imageLink]`
  - `Tên sản phẩm`
  - `Mã sản phẩm`
  - `Danh mục`
  - `Giá`
  - `Amount`
  - `Description`

---

### Câu 5 (3.0 điểm): CRUD Category & Product có Phân trang
Đăng nhập tài khoản `admin` / pass `123456`, bấm **Trang Quản Trị**:
1. **Quản lý Category (`/admin/categories`)**:
   - Có phân trang (5 danh mục/trang).
   - Thêm mới danh mục: Bấm nút *Thêm Danh Mục*.
   - Sửa danh mục: Bấm icon bút chì màu vàng.
   - Xóa danh mục: Bấm icon thùng rác màu đỏ (có cảnh báo xác nhận).
2. **Quản lý Product (`/admin/products`)**:
   - Có phân trang (5 sản phẩm/trang).
   - Form thêm/sửa có dropdown chọn Category và Seller.
   - Hỗ trợ đầy đủ Thêm, Sửa, Xóa.

---

### 🛒 Chức Năng Bổ Sung: Quản Lý Giỏ Hàng (Shopping Cart)
- **URL truy cập**: `http://localhost:8080/DTQT05/cart` (hoặc bấm biểu tượng **Giỏ hàng** trên thanh Header).
1. **Thêm vào giỏ**:
   - Tại trang danh sách sản phẩm (`/products`): Bấm nút **Thêm vào giỏ**.
   - Tại trang chi tiết sản phẩm (`/product/detail?id=...`): Chọn số lượng mua và bấm **Thêm vào giỏ** hoặc **Mua ngay**.
2. **Sửa & Thay đổi số lượng trong giới hạn**:
   - Bấm nút `[+]` hoặc `[-]` để tăng/giảm số lượng từng đơn vị.
   - Nhập trực tiếp số lượng vào ô input: Hệ thống tự động kiểm tra giới hạn (tối thiểu là 1, tối đa không vượt quá số lượng tồn kho `stock`/`amount` của sản phẩm). Nếu nhập vượt quá, hệ thống tự động điều chỉnh về mức tối đa và thông báo cảnh báo.
3. **Xóa sản phẩm**:
   - Bấm icon thùng rác để xóa từng sản phẩm.
   - Bấm **Xóa tất cả** để làm trống toàn bộ giỏ hàng.
4. **Thanh toán & Đặt hàng (`/cart/checkout`)**:
   - Tự động tính thành tiền từng mặt hàng (`đơn giá * số lượng`) và tổng tiền thanh toán giỏ hàng.
   - Người dùng đăng nhập có thể bấm **Tiến Hành Đặt Hàng** để lưu đơn hàng vào 2 bảng `Cart` và `CartItem` trong CSDL.

