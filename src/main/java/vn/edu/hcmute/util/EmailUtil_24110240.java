package vn.edu.hcmute.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.InputStream;
import java.util.Properties;
import java.util.Random;

public class EmailUtil_24110240 {

    private static String host = "smtp.gmail.com";
    private static String port = "587";
    private static String username = "vikhangcv@gmail.com";
    private static String password = "aotebgxlzfdckovh";

    static {
        loadProperties();
    }

    private static void loadProperties() {
        try (InputStream input = EmailUtil_24110240.class.getClassLoader().getResourceAsStream("email.properties")) {
            if (input != null) {
                Properties prop = new Properties();
                prop.load(input);
                host = prop.getProperty("mail.smtp.host", host).trim();
                port = prop.getProperty("mail.smtp.port", port).trim();
                username = prop.getProperty("mail.username", username).trim();
                password = prop.getProperty("mail.password", password).trim();
            }
        } catch (Exception e) {
            System.err.println("Không thể đọc file email.properties, dùng cấu hình mặc định: " + e.getMessage());
        }
    }

    /**
     * Sinh mã OTP 6 chữ số ngẫu nhiên
     */
    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    /**
     * Gửi email thật sự qua giao thức SMTP Gmail
     */
    public static boolean sendOtpEmail(String toEmail, String otpCode) {
        // In ra Console để theo dõi trực tiếp
        System.out.println("==========================================================");
        System.out.println(">>> ĐANG TIẾN HÀNH GỬI EMAIL THẬT TỚI: " + toEmail);
        System.out.println(">>> MÃ OTP KÍCH HOẠT LÀ: [ " + otpCode + " ]");
        System.out.println(">>> Tài khoản gửi (SMTP): " + username);
        System.out.println("==========================================================");

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");
        props.put("mail.smtp.ssl.trust", host);

        // Thiết lập timeout để không bị treo server nếu mạng chậm
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout", "10000");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        // Bật debug để in chi tiết hội thoại SMTP ra Console nếu cần kiểm tra
        session.setDebug(false);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username, "HCMUTE Shop"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã xác thực kích hoạt tài khoản - HCMUTE Shop");

            String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #e9ecef; border-radius: 8px; overflow: hidden;'>"
                    + "<div style='background-color: #0d6efd; color: #ffffff; padding: 20px; text-align: center;'>"
                    + "<h2 style='margin: 0;'>Xác Thực Tài Khoản</h2>"
                    + "</div>"
                    + "<div style='padding: 30px; background-color: #ffffff;'>"
                    + "<p style='font-size: 16px; color: #333333;'>Xin chào,</p>"
                    + "<p style='font-size: 16px; color: #333333;'>Bạn vừa đăng ký tài khoản trên hệ thống HCMUTE Shop. Mã OTP xác thực của bạn là:</p>"
                    + "<div style='text-align: center; margin: 25px 0;'>"
                    + "<span style='display: inline-block; background-color: #f8f9fa; border: 2px dashed #0d6efd; color: #d63384; font-size: 32px; font-weight: bold; letter-spacing: 8px; padding: 12px 24px; border-radius: 8px;'>"
                    + otpCode + "</span>"
                    + "</div>"
                    + "<p style='font-size: 14px; color: #6c757d;'>Mã xác thực có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã này với bất kỳ ai.</p>"
                    + "</div>"
                    + "<div style='background-color: #f8f9fa; padding: 15px; text-align: center; font-size: 12px; color: #6c757d; border-top: 1px solid #e9ecef;'>"
                    + "HCMUTE Shop &copy; 2026. Đây là email tự động, vui lòng không phản hồi."
                    + "</div>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);

            System.out.println(">>> [THÀNH CÔNG] Đã gửi email chứa mã OTP đến: " + toEmail);
            return true;
        } catch (AuthenticationFailedException e) {
            System.err.println(">>> [LỖI XÁC THỰC SMTP GMAIL] 535-5.7.8 Username and Password not accepted!");
            System.err.println(">>> NGUYÊN NHÂN: Bạn chưa dùng 'Mật khẩu ứng dụng' (App Password 16 ký tự) của Google.");
            System.err.println(">>> Hãy vào: https://myaccount.google.com/apppasswords để tạo mã 16 ký tự và dán vào file email.properties.");
            return false;
        } catch (Exception e) {
            System.err.println(">>> [LỖI GỬI EMAIL]: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
