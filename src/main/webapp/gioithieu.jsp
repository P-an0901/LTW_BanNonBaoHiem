<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới Thiệu - Cửa hàng Mũ Bảo Hiểm</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">

</head>
<body>
<!-- Load header -->
<jsp:include page="html/header.jsp" />

<!-- Load modal -->
<jsp:include page="html/modal.jsp" />

<!-- Nội dung chính -->
<div class="container mt-4">
    <!-- Banner -->
    <div class="jumbotron text-center bg-primary text-white">
        <h1 class="display-4">Về Cửa Hàng Mũ Bảo Hiểm</h1>
        <p class="lead">An toàn và phong cách đồng hành cùng bạn trên mọi cung đường.</p>
    </div>

    <!-- Chúng tôi là ai -->
    <section class="my-5">
        <div class="row">
            <div class="col-md-6">
                <h2>Chúng Tôi Là Ai?</h2>
                <p>
                    Cửa hàng Mũ Bảo Hiểm HELMET được thành lập với sứ mệnh mang đến những sản phẩm bảo hộ chất lượng, đảm bảo an toàn cho người tham gia giao thông.
                    Với sự nỗ lực không ngừng, chúng tôi tự hào là địa chỉ tin cậy của nhiều khách hàng yêu thích mũ bảo hiểm an toàn, phong cách.
                </p>
                <p>
                    Chúng tôi cam kết chỉ cung cấp những sản phẩm mũ bảo hiểm đạt tiêu chuẩn, thiết kế đa dạng và cập nhật xu hướng thời trang, để bạn có thể tự tin trên mọi hành trình.
                </p>
            </div>
            <div class="col-md-6">
                <img src="images/HELMET.png" alt="Giới thiệu cửa hàng" class="img-fluid rounded">
            </div>
        </div>
    </section>

    <!-- Giá trị cốt lõi -->
    <section class="my-5">
        <h2 class="text-center">Giá Trị Cốt Lõi</h2>
        <div class="row text-center mt-4">
            <div class="col-md-4">
                <i class="fas fa-shield-alt fa-3x text-primary mb-3"></i>
                <h4>Chất Lượng</h4>
                <p>Sản phẩm của chúng tôi luôn được chọn lọc kỹ càng để mang lại độ bền và an toàn cao nhất cho khách hàng.</p>
            </div>
            <div class="col-md-4">
                <i class="fas fa-thumbs-up fa-3x text-primary mb-3"></i>
                <h4>Uy Tín</h4>
                <p>Chúng tôi coi trọng sự uy tín, luôn đặt quyền lợi của khách hàng lên hàng đầu trong mọi giao dịch.</p>
            </div>
            <div class="col-md-4">
                <i class="fas fa-users fa-3x text-primary mb-3"></i>
                <h4>Khách Hàng Là Trọng Tâm</h4>
                <p>Luôn lắng nghe, thấu hiểu và cải tiến để đáp ứng nhu cầu của khách hàng một cách tốt nhất.</p>
            </div>
        </div>
    </section>

    <!-- Đội ngũ nhân viên -->
    <section class="my-5">
        <h2 class="text-center">Đội Ngũ Chuyên Nghiệp</h2>
        <p class="text-center">
            Đội ngũ nhân viên nhiệt tình và chuyên nghiệp, luôn sẵn sàng hỗ trợ bạn trong việc lựa chọn sản phẩm phù hợp và giải đáp mọi thắc mắc.
        </p>
    </section>
</div>

<!-- Load footer -->
<jsp:include page="html/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="js/index.js"></script>
<script src="js/modal.js"></script>
<script src="js/header.js"></script>
</body>
</html>
