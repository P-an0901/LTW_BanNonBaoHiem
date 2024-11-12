function addSampleAccount() {
    let accounts = JSON.parse(localStorage.getItem('accounts')) || [];

    // Nếu chưa có tài khoản, thêm một tài khoản mẫu
    if (accounts.length === 0) {
        accounts.push({
            fullName: 'Nguyen Van A',
            phone: '0123456789',
            password: '123456'
        });
        // Lưu tài khoản vào localStorage
        localStorage.setItem('accounts', JSON.stringify(accounts));
    }
}
addSampleAccount();


// Hàm xử lý đăng ký
function handleSignup(event) {
    event.preventDefault();

    let fullNameUser = document.getElementById('fullname').value;
    let phoneUser = document.getElementById('phone').value;
    let passwordUser = document.getElementById('password').value;
    let passwordConfirmation = document.getElementById('password_confirmation').value;
    let checkSignup = document.getElementById('checkbox-signup').checked;

    // Kiểm tra validate
    validateSignup(fullNameUser, phoneUser, passwordUser, passwordConfirmation, checkSignup);

    // Nếu thông tin hợp lệ, lưu vào localStorage
    if (fullNameUser.length >= 6 && phoneUser.length == 10 && passwordUser.length >= 6 && passwordUser === passwordConfirmation && checkSignup) {
        let accounts = JSON.parse(localStorage.getItem('accounts')) || [];
        accounts.push({ fullName: fullNameUser, phone: phoneUser, password: passwordUser });
        localStorage.setItem('accounts', JSON.stringify(accounts));
        return true;
    }
}

// Hàm kiểm tra và hiển thị thông báo lỗi trong đăng ký
function validateSignup(fullNameUser, phoneUser, passwordUser, passwordConfirmation, checkSignup) {
    if (fullNameUser.length == 0) {
        document.querySelector('.form-message-name').innerHTML = 'Vui lòng nhập họ và tên';
        document.getElementById('fullname').focus();
    } else if (fullNameUser.length < 6) {
        document.getElementById('fullname').value = '';
        document.querySelector('.form-message-name').innerHTML = 'Vui lòng nhập họ và tên lớn hơn 6 kí tự';
    } else {
        document.querySelector('.form-message-name').innerHTML = '';
    }

    if (phoneUser.length == 0) {
        document.querySelector('.form-message-phone').innerHTML = 'Vui lòng nhập vào số điện thoại';
    } else if (phoneUser.length != 10) {
        document.querySelector('.form-message-phone').innerHTML = 'Vui lòng nhập vào số điện thoại 10 số';
        document.getElementById('phone').value = '';
    } else {
        document.querySelector('.form-message-phone').innerHTML = '';
    }

    if (passwordUser.length == 0) {
        document.querySelector('.form-message-password').innerHTML = 'Vui lòng nhập mật khẩu';
    } else if (passwordUser.length < 6) {
        document.querySelector('.form-message-password').innerHTML = 'Vui lòng nhập mật khẩu lớn hơn 6 kí tự';
        document.getElementById('password').value = '';
    } else {
        document.querySelector('.form-message-password').innerHTML = '';
    }

    if (passwordConfirmation.length == 0) {
        document.querySelector('.form-message-password-confi').innerHTML = 'Vui lòng nhập lại mật khẩu';
    } else if (passwordConfirmation !== passwordUser) {
        document.querySelector('.form-message-password-confi').innerHTML = 'Mật khẩu không khớp';
        document.getElementById('password_confirmation').value = '';
    } else {
        document.querySelector('.form-message-password-confi').innerHTML = '';
    }

    if (!checkSignup) {
        document.querySelector('.form-message-checkbox').innerHTML = 'Vui lòng kiểm tra đăng ký';
    } else {
        document.querySelector('.form-message-checkbox').innerHTML = '';
    }
}

// Hàm xử lý đăng nhập
function handleLogin(event) {
    event.preventDefault();

    let phonelog = document.getElementById('phone-login').value;
    let passlog = document.getElementById('password-login').value;
    let accounts = JSON.parse(localStorage.getItem('accounts'));

    validateLogin(phonelog, passlog);

    // Nếu thông tin hợp lệ thì tiến hành tìm tài khoản
    if (phonelog.length === 10 && passlog.length >= 6) {
        let accountFound = accounts.find(account => account.phone === phonelog && account.password === passlog);
        return accountFound;
    } else {
        return null; // Nếu không hợp lệ, trả về null
    }
}

// Hàm kiểm tra và hiển thị thông báo lỗi trong đăng nhập
function validateLogin(phonelog, passlog) {
    if (phonelog.length == 0) {
        document.querySelector('.form-message.phonelog').innerHTML = 'Vui lòng nhập vào số điện thoại';
    } else if (phonelog.length != 10) {
        document.querySelector('.form-message.phonelog').innerHTML = 'Vui lòng nhập vào số điện thoại 10 số';
        document.getElementById('phone-login').value = '';
    } else {
        document.querySelector('.form-message.phonelog').innerHTML = '';
    }

    if (passlog.length == 0) {
        document.querySelector('.form-message-check-login').innerHTML = 'Vui lòng nhập mật khẩu';
    } else if (passlog.length < 6) {
        document.querySelector('.form-message-check-login').innerHTML = 'Vui lòng nhập mật khẩu lớn hơn 6 kí tự';
        document.getElementById('password-login').value = '';
    } else {
        document.querySelector('.form-message-check-login').innerHTML = '';
    }
}
