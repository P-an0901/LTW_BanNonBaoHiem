$(document).ready(function(){
    $('#loginForm').submit(function(event){
        event.preventDefault();
        var username = $('#username-login').val();
        var password = $('#password-login').val();

        $.ajax({
            url: '/LTW_BanNonBaoHiem/login',
            method: 'POST',
            data: { username: username, password: password },
            success: function(response) {
                if (response.loginSuccess) {
                    location.reload();
                }
            },
            error: function(xhr) {
                var errors = JSON.parse(xhr.responseText);
                $('.form-message').text('').hide();

                if (errors.loginError) {
                    $('.form-message-login').text(errors.loginError).show();
                }
                if (errors.username) {
                    $('.form-message-username-check-login').text(errors.username).show();
                }
                if (errors.password) {
                    $('.form-message-check-login').text(errors.password).show();
                }
                $('#signup-login').modal('show');
            }
        });
    });
    $('#registerForm').submit(function(event){
        event.preventDefault();
        var username = $('#username').val();
        var password = $('#password').val();
        var confirmPassword = $('#password_confirmation').val();
        var email = $('#email').val();
        var fullName = $('#fullName').val();

        $.ajax({
            url: '/LTW_BanNonBaoHiem/register',
            method: 'POST',
            data: {
                username: username,
                password: password,
                confirmPassword: confirmPassword,
                email: email,
                fullName: fullName
            },
            success: function(response) {
                if (response.registerSuccess) {
                    location.reload();
                }
            },
            error: function(xhr) {
                var errors = JSON.parse(xhr.responseText);

                $('.form-message').text('').hide();


                if (errors.loginError) {
                    $('.form-message-register').text(errors.loginError).show();
                }
                if (errors.username) {
                    $('.form-message-username').text(errors.username).show();
                }
                if (errors.password) {
                    $('.form-message-password').text(errors.password).show();
                }
                if (errors.confirmPass) {
                    $('.form-message-password-confi').text(errors.confirmPass).show();
                }
                if (errors.email) {
                    $('.form-message-email').text(errors.email).show();
                }
                if (errors.name) {
                    $('.form-message-name').text(errors.name).show();
                }
                $('#signup-login').modal('show');
            }
        });
    });
});
