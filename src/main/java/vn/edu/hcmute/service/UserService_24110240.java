package vn.edu.hcmute.service;

import vn.edu.hcmute.dao.UserDAO_24110240;
import vn.edu.hcmute.model.User;
import vn.edu.hcmute.model.UserRole;
import vn.edu.hcmute.util.EmailUtil_24110240;

public class UserService_24110240 {

    private final UserDAO_24110240 userDAO = new UserDAO_24110240();

    /**
     * Đăng ký tài khoản mới:
     * - Kiểm tra trùng lặp
     * - Sinh mã OTP 6 số
     * - Gửi OTP qua email (và log ra console)
     * - Lưu tài khoản với status = 0 (Chờ kích hoạt)
     */
    public boolean register(String username, String email, String fullname, String password, String phone) throws Exception {
        if (userDAO.findByUsername(username) != null) {
            throw new Exception("Tên đăng nhập '" + username + "' đã được sử dụng!");
        }
        if (userDAO.findByEmail(email) != null) {
            throw new Exception("Email '" + email + "' đã được đăng ký tài khoản khác!");
        }

        String otp = EmailUtil_24110240.generateOtp();

        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setFullname(fullname != null ? fullname.trim() : username);
        user.setPassword(password);
        user.setPhone(phone);
        user.setStatus(0); // Chưa kích hoạt
        user.setCode(otp);

        // Gán Role mặc định là USER
        UserRole userRole = userDAO.findRoleByName("USER");
        user.setRole(userRole);

        userDAO.create(user);

        // Gửi mail kích hoạt
        EmailUtil_24110240.sendOtpEmail(email, otp);
        return true;
    }

    /**
     * Xác thực mã OTP kích hoạt tài khoản
     */
    public boolean verifyOtp(String username, String otpCode) {
        User user = userDAO.findByUsernameAndCode(username, otpCode);
        if (user != null) {
            user.setStatus(1); // Đã kích hoạt
            user.setCode(null); // Xóa OTP sau khi dùng
            userDAO.update(user);
            return true;
        }
        return false;
    }

    /**
     * Đăng nhập người dùng (kiểm tra mật khẩu và trạng thái kích hoạt status = 1)
     */
    public User authenticate(String username, String password) throws Exception {
        User user = userDAO.findByUsername(username);
        if (user == null) {
            throw new Exception("Tài khoản không tồn tại!");
        }
        if (!user.getPassword().equals(password)) {
            throw new Exception("Mật khẩu không chính xác!");
        }
        if (user.getStatus() != 1) {
            throw new Exception("Tài khoản chưa được kích hoạt OTP! Vui lòng kích hoạt trước khi đăng nhập.");
        }
        return user;
    }
}
