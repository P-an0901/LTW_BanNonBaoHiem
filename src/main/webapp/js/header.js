document.addEventListener("DOMContentLoaded", function() {
    const accountMenu = document.getElementById("account-menu");
    if (accountMenu) {
        accountMenu.addEventListener("click", function(event) {
            event.stopPropagation();
            const dropdownMenu = this.querySelector(".dropdown-menu");
            dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none" : "block";
        });
    }
});


// Đóng dropdown khi nhấp ra ngoài
document.addEventListener("click", function() {
    const dropdownMenu = document.querySelector("#account-menu .dropdown-menu");
    if (dropdownMenu) {
        dropdownMenu.style.display = "none";
    }
});
$(function() {
    const searchUrl = './search';

    $('#searchInput').on('input', function () {
        var query = $(this).val();

        if (query.length > 0) {
            $.ajax({
                url: searchUrl,
                method: 'GET',
                data: { q: query },
                success: function (data) {
                    console.log(data);
                    displayResults(data);
                },
                error: function () {
                    alert('Lỗi khi tìm kiếm!');
                }
            });
        } else {
            $('#searchResults').addClass('hidden');
        }
    });

    $('#searchInput').on('keypress', function (e) {
        if (e.which == 13) { // Kiểm tra phím Enter
            var query = $(this).val();
            if (query.length > 0) {
                window.location.href = `${searchUrl}?q=${query}`;
            }
        }
    });

    function displayResults(products) {
        var $searchResults = $('#searchResults');
        $searchResults.empty();

        if (products.length > 0) {

            $.each(products, function (index, product) {

                const resultItem = `
               <li class="search-item" data-id="${product.id}">
                <a href="./detail?pvId=${product.id}" title="Xem chi tiết sản phẩm">
                    <img src="${product.image}" alt="${product.name}" style="width: 50px; height: 50px; margin-right: 10px;">
                    <span>${product.name}</span> - 
                    <span style="text-decoration: ${product.salePrice > 0 ? 'line-through' : 'none'};">
                            ${product.price} đ
                    </span>
                        ${product.salePrice > 0 ? ` - <span style="color: red;">${product.salePrice} đ</span>` : ''}
                </a>
            </li>
                `;
                $searchResults.append(resultItem);
            });
            $searchResults.removeClass('hidden');
        } else {
            $searchResults.append('<li>Không tìm thấy sản phẩm.</li>');
            $searchResults.removeClass('hidden');
        }

        $('.search-item').click(function () {
            var productId = $(this).data('id');
            window.location.href = `${searchUrl}?id=${productId}`;
        });
    }
});
