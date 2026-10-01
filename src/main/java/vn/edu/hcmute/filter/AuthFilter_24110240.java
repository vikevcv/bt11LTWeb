package vn.edu.hcmute.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.model.User;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter_24110240", urlPatterns = {"/admin/*", "/seller/*"})
public class AuthFilter_24110240 implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        String uri = req.getRequestURI();

        // Kiểm tra quyền truy cập Admin
        if (uri.contains("/admin/")) {
            if (currentUser == null || currentUser.getRole() == null || !"ADMIN".equalsIgnoreCase(currentUser.getRole().getRoleName())) {
                req.getSession().setAttribute("flashType", "danger");
                req.getSession().setAttribute("flashMessage", "Bạn không có quyền truy cập khu vực Quản trị (Admin)!");
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
        }

        // Kiểm tra quyền truy cập Seller
        if (uri.contains("/seller/")) {
            if (currentUser == null || currentUser.getRole() == null || 
                (!"SELLER".equalsIgnoreCase(currentUser.getRole().getRoleName()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole().getRoleName()))) {
                req.getSession().setAttribute("flashType", "danger");
                req.getSession().setAttribute("flashMessage", "Bạn cần đăng nhập bằng tài khoản Seller!");
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
