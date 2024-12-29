<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "f" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<div class="modal fade" id="signup-login" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="forms mdl-cnt">
                    <div class="form-content sign-up">
                        <h3 class="form-title">Đăng ký tài khoản</h3>
                        <p class="form-description">Đăng ký thành viên để mua hàng và nhận những ưu đãi đặc biệt từ chúng tôi</p>
                        <form action="register" method="post" id="registerForm" class="signup-form">
                            <span class="form-message-register form-message"></span>
                            <div class="form-group">
                                <label for="fullName" class="form-label">Tên đầy đủ <span class="text-danger">*</span></label>
                                <input id="fullName" name="name" type="text" placeholder="VD: Nguyễn Văn A" class="form-control">
                                <span class="form-message-name form-message"></span>
                            </div>
                            <div class="form-group">
                                <label for="username" class="form-label">Tên đăng nhập<span class="text-danger">*</span></label>
                                <input id="username" name="username" type="text" placeholder="Nhập tên đăng nhập" class="form-control">
                                <span class="form-message-username form-message"></span>
                            </div>
                            <div class="form-group">
                                <label for="email" class="form-label">Email</label>
                                <input id="email" name="email" type="email" placeholder="Nhập email" class="form-control">
                                <span class="form-message-email form-message"></span>
                            </div>
                            <div class="form-group">
                                <label for="password" class="form-label">Mật khẩu<span class="text-danger">*</span></label>
                                <input id="password" name="password" type="password" placeholder="Nhập mật khẩu" class="form-control">
                                <span class="form-message-password form-message"></span>
                            </div>
                            <div class="form-group">
                                <label for="password_confirmation" class="form-label">Nhập lại mật khẩu<span class="text-danger">*</span></label>
                                <input id="password_confirmation" name="password_confirmation" placeholder="Nhập lại mật khẩu" type="password" class="form-control">
                                <span class="form-message-password-confi form-message"></span>
                            </div>
                            <div class="form-group form-check">
                                <input class="form-check-input" type="checkbox" id="checkbox-signup" required>
                                <label class="form-check-label" for="checkbox-signup">Tôi đồng ý với <a href="#" title="chính sách trang web" target="_blank">chính sách trang web</a></label>
                                <p class="form-message-checkbox form-message"></p>
                            </div>
                            <button type="submit" class="form-submit " id="signup-button">Đăng ký</button>
                        </form>
                        <p class="change-login">Bạn đã có tài khoản? <a href="#" class="login-link">Đăng nhập ngay</a></p>
                    </div>
                    <div class="form-content login">
                        <h3 class="form-title">Đăng nhập tài khoản</h3>
                        <p class="form-description">Đăng nhập thành viên để mua hàng và nhận những ưu đãi đặc biệt từ chúng tôi</p>
                        <form action="login" method="post" id="loginForm" class="login-form">
                            <span class="form-message-login form-message"></span>
                            <div class="form-group">
                                <label for="username-login" class="form-label">Tên đăng nhập</label>
                                <input id="username-login" name="username" type="text" placeholder="Nhập tên đăng nhập" class="form-control">
                                <span class="form-message-username-check-login form-message"></span>
                            </div>
                            <div class="form-group">
                                <label for="password-login" class="form-label">Mật khẩu</label>
                                <input id="password-login" name="password" type="password" placeholder="Nhập mật khẩu" class="form-control">
                                <span class="form-message-check-login form-message"></span>
                            </div>
                            <p class="forgot-password"><a href="#" class="forgot-password-link">Quên mật khẩu?</a></p>
                            <button type="submit" class="form-submit " id="login-button">Đăng nhập</button>
                        </form>
                        <p class="change-login">Bạn chưa có tài khoản? <a href="#" class="signup-link">Đăng kí ngay</a></p>
                        <div class="social-login">
                            <p>Hoặc</p>
                            <div class="social-buttons">
                                <button class="social-button" onclick="loginWithFacebook()">
                                    <i class="fa-brands fa-facebook-f"></i>
                                </button>
                                <button class="social-button" onclick="loginWithGoogle()">
                                    <i class="fa-brands fa-google"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="form-content forgot-password-form">
                        <h3 class="form-title">Quên mật khẩu</h3>
                        <p class="form-description">Nhập email của bạn để lấy lại mật khẩu</p>
                        <form action="" class="forgot-password-form">
                            <div class="form-group">
                                <label for="forgot-email" class="form-label">Email</label>
                                <input id="forgot-email" name="email" type="email" placeholder="Nhập email" class="form-control">
                                <span class="form-message forgot-email-message"></span>
                            </div>
                            <button type="submit" class="form-submit" id="reset-button">Gửi yêu cầu</button>
                        </form>
                        <p class="change-login">Bạn đã nhớ mật khẩu? <a href="#" class="login-link">Đăng nhập ngay</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
