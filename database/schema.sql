-- ========================================================
-- ĐỀ THI QUÁ TRÌNH - HK1 - 2026-2027
-- MÔN: LẬP TRÌNH WEB - ĐỀ SỐ 05 (HCMUTE - GV: Nguyễn Hữu Trung)
-- Script Database MySQL
-- ========================================================

CREATE DATABASE IF NOT EXISTS dtqt05
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE dtqt05;

-- Xóa bảng cũ nếu tồn tại (theo thứ tự khóa ngoại)
DROP TABLE IF EXISTS CartItem;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Seller;
DROP TABLE IF EXISTS UserRoles;

-- 1. Bảng UserRoles
CREATE TABLE UserRoles (
    roleId INT AUTO_INCREMENT PRIMARY KEY,
    roleName NVARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Bảng Seller
CREATE TABLE Seller (
    sellerId INT AUTO_INCREMENT PRIMARY KEY,
    sellername NVARCHAR(50) NOT NULL,
    images NVARCHAR(500),
    status INT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Bảng Users
CREATE TABLE Users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    email NVARCHAR(100) NOT NULL,
    fullname NVARCHAR(50),
    password NVARCHAR(50) NOT NULL,
    images NVARCHAR(500),
    phone NVARCHAR(20),
    status INT DEFAULT 0, -- 0: Chưa kích hoạt OTP, 1: Đã kích hoạt
    code NVARCHAR(50),    -- Mã OTP kích hoạt qua mail
    roleId INT,
    sellerId INT,
    CONSTRAINT FK_Users_Role FOREIGN KEY (roleId) REFERENCES UserRoles(roleId) ON DELETE SET NULL,
    CONSTRAINT FK_Users_Seller FOREIGN KEY (sellerId) REFERENCES Seller(sellerId) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Bảng Category
CREATE TABLE Category (
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName NVARCHAR(200) NOT NULL,
    images NVARCHAR(500),
    status INT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Bảng Product
CREATE TABLE Product (
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName NVARCHAR(200) NOT NULL,
    productCode BIGINT,
    categoryId INT,
    description NVARCHAR(500),
    price FLOAT DEFAULT 0,
    amount INT DEFAULT 0,
    stock INT DEFAULT 0,
    images NVARCHAR(500),
    wishlist INT DEFAULT 0,
    status INT DEFAULT 1,
    createDate DATE,
    sellerId INT,
    CONSTRAINT FK_Product_Category FOREIGN KEY (categoryId) REFERENCES Category(categoryId) ON DELETE SET NULL,
    CONSTRAINT FK_Product_Seller FOREIGN KEY (sellerId) REFERENCES Seller(sellerId) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Bảng Cart
CREATE TABLE Cart (
    cartId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    buyDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    status INT DEFAULT 0, -- 0: Chờ xác nhận COD, 1: Đang giao hàng (COD), 2: Giao thành công & Đã thanh toán, -1: Đã hủy
    receiverName NVARCHAR(100),
    receiverPhone NVARCHAR(20),
    shippingAddress NVARCHAR(300),
    note NVARCHAR(500),
    paymentMethod NVARCHAR(50) DEFAULT 'COD',
    totalAmount FLOAT DEFAULT 0,
    CONSTRAINT FK_Cart_User FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Bảng CartItem
CREATE TABLE CartItem (
    cartItemId INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT DEFAULT 1,
    unitPrice FLOAT DEFAULT 0,
    productId INT,
    cartId INT,
    CONSTRAINT FK_CartItem_Product FOREIGN KEY (productId) REFERENCES Product(productId) ON DELETE CASCADE,
    CONSTRAINT FK_CartItem_Cart FOREIGN KEY (cartId) REFERENCES Cart(cartId) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========================================================
-- CHÈN DỮ LIỆU MẪU ĐỂ TEST NGAY
-- ========================================================

-- Chèn Roles
INSERT INTO UserRoles (roleId, roleName) VALUES 
(1, 'ADMIN'),
(2, 'USER'),
(3, 'SELLER');

-- Chèn Sellers
INSERT INTO Seller (sellerId, sellername, images, status) VALUES 
(1, 'Cửa hàng Thế Giới Công Nghệ', 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300', 1),
(2, 'Nhà Sách Tri Thức', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=300', 1),
(3, 'Cửa hàng Thời Trang Phố', 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=300', 1);

-- Chèn Users (Tài khoản mẫu: mật khẩu đều là 123456)
INSERT INTO Users (username, email, fullname, password, images, phone, status, code, roleId, sellerId) VALUES 
('admin', 'admin@hcmute.edu.vn', 'Quản Trị Viên', '123456', 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', '0901234567', 1, NULL, 1, NULL),
('seller01', 'seller01@store.vn', 'Chủ Cửa Hàng Công Nghệ', '123456', 'https://cdn-icons-png.flaticon.com/512/3135/3135768.png', '0912345678', 1, NULL, 3, 1),
('seller02', 'seller02@store.vn', 'Chủ Nhà Sách', '123456', 'https://cdn-icons-png.flaticon.com/512/3135/3135768.png', '0923456789', 1, NULL, 3, 2),
('user01', 'sinhvien@hcmute.edu.vn', 'Nguyễn Văn A', '123456', 'https://cdn-icons-png.flaticon.com/512/3135/3135789.png', '0934567890', 1, NULL, 2, NULL);

-- Chèn Danh mục (Category)
INSERT INTO Category (categoryId, categoryName, images, status) VALUES 
(1, 'Điện thoại & Phụ kiện', 'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=300', 1),
(2, 'Laptop & Máy tính', 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300', 1),
(3, 'Sách Giáo Trình & Công Nghệ', 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300', 1),
(4, 'Thời Trang & Phụ Kiện', 'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=300', 1);

-- Chèn Sản phẩm (Product) phục vụ Câu 3 (Gom nhóm theo Seller) & Câu 4 (Chi tiết)
INSERT INTO Product (productName, productCode, categoryId, description, price, amount, stock, images, wishlist, status, createDate, sellerId) VALUES 
-- Thuộc Seller 1 (Công Nghệ)
('iPhone 15 Pro Max 256GB', 100101, 1, 'Khung Titan chuẩn hàng không vũ trụ, chip A17 Pro mạnh mẽ nhất.', 29990000, 15, 20, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300', 12, 1, '2026-09-01', 1),
('MacBook Air M3 15 inch', 100102, 2, 'Thiết kế siêu mỏng nhẹ, pin 18 tiếng, màn hình Liquid Retina tuyệt đẹp.', 32890000, 8, 10, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300', 5, 1, '2026-09-05', 1),
('Chuột Không Dây Logitech MX Master 3S', 100103, 1, 'Cuộn siêu tốc MagSpeed, cảm biến 8K DPI trên mọi bề mặt.', 2150000, 30, 50, 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=300', 2, 1, '2026-09-10', 1),

-- Thuộc Seller 2 (Nhà Sách)
('Giáo Trình Lập Trình Web Java Servlet & JPA', 200201, 3, 'Tài liệu hướng dẫn thực hành chuyên sâu từ cơ bản đến nâng cao cho sinh viên CNTT.', 125000, 50, 100, 'https://images.unsplash.com/photo-1532012164546-f432f2e3edd4?w=300', 40, 1, '2026-09-12', 2),
('Clean Code - Nghệ Thuật Viết Code Sạch', 200202, 3, 'Cuốn sách gối đầu giường của mọi lập trình viên chuyên nghiệp.', 250000, 20, 35, 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=300', 85, 1, '2026-09-15', 2),

-- Thuộc Seller 3 (Thời Trang)
('Áo Polo Nam Co Giãn 4 Chiều', 300301, 4, 'Chất liệu Cotton pha Spandex thoáng mát, thấm hút mồ hôi tối đa.', 289000, 45, 60, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=300', 8, 1, '2026-09-18', 3),
('Quần Jean Slimfit Co Giãn', 300302, 4, 'Phong cách trẻ trung năng động, tôn dáng.', 450000, 18, 25, 'https://images.unsplash.com/photo-1542272604-780c96856592?w=300', 15, 1, '2026-09-20', 3);
