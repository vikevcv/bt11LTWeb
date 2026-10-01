package vn.edu.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.model.User;
import vn.edu.hcmute.service.UserService_24110240;

import java.io.IOException;

@WebServlet(name = "AuthController_24110240", urlPatterns = {"/login", "/register", "/verify-otp", "/logout"})
public class AuthController_24110240 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService_24110240 userService = new UserService_24110240();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();

        switch (servletPath) {
            case "/register":
                req.setAttribute("pageTitle", "Đăng ký tài khoản");
                req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
                break;
            case "/verify-otp":
                req.setAttribute("pageTitle", "Xác thực mã OTP");
                req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(req, resp);
                break;
            case "/logout":
                handleLogout(req, resp);
                break;
            case "/login":
            default:
                req.setAttribute("pageTitle", "Đăng nhập hệ thống");
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();

        switch (servletPath) {
            case "/register":
                handleRegister(req, resp);
                break;
            case "/verify-otp":
                handleVerifyOtp(req, resp);
                break;
            case "/login":
            default:
                handleLogin(req, resp);
                break;
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User user = userService.authenticate(username, password);

            // Lưu phiên làm việc vào Session
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);

            setFlash(req, "success", "Đăng nhập thành công! Xin chào " + user.getFullname());

            // Điều hướng theo vai trò (Role): Seller vào trang Seller, User/Admin vào trang User
            if (user.getRole() != null && "SELLER".equalsIgnoreCase(user.getRole().getRoleName())) {
                resp.sendRedirect(req.getContextPath() + "/seller/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } catch (Exception e) {
            setFlash(req, "danger", e.getMessage());
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        try {
            userService.register(username, email, fullname, password, phone);
            setFlash(req, "info", "Đăng ký thành công! Mã OTP kích hoạt đã được gửi tới email " + email + ". Vui lòng nhập mã để kích hoạt tài khoản.");
            resp.sendRedirect(req.getContextPath() + "/verify-otp?username=" + username);
        } catch (Exception e) {
            setFlash(req, "danger", e.getMessage());
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        }
    }

    private void handleVerifyOtp(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("username");
        String otpCode = req.getParameter("otpCode");

        boolean isVerified = userService.verifyOtp(username, otpCode);
        if (isVerified) {
            setFlash(req, "success", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            setFlash(req, "danger", "Mã OTP không chính xác hoặc tài khoản đã được kích hoạt trước đó!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(req, resp);
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    private void setFlash(HttpServletRequest req, String type, String msg) {
        HttpSession session = req.getSession();
        session.setAttribute("flashType", type);
        session.setAttribute("flashMessage", msg);
    }
}
