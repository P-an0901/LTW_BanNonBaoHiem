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

const searchInput = document.getElementById("searchInput");
const searchResults = document.getElementById("searchResults");

// Mock dữ liệu
const productseach = [
    { name: "Royal M139 BOOMBANG", price: "650.000 đ", img: "images/Royal-M139-BoomBang.jpg",url: "detail.html" },
    { name: "Royal M139 CHUỘT XƯỚC", price: "200.000 đ", img: "images/Royal-M139-Chuot-xuoc-bong.jpg" },
    { name: "Royal M139 ĐEN MỜ", price: "150.000 đ", img: "images/Royal-M139-Den-mo.jpg" },
    { name: "Royal M139 LEOPARD", price: "250.000 đ", img: "images/Royal-M139-Leopard.jpg" },
    { name: "Royal M139 V.1", price: "300.000 đ", img: "#" },
    { name: "Royal ROYAL M139 VÀNG BÓNG", price: "100.000 đ", img: "#" },
    { name: "Royal M139 V.2", price: "100.000 đ", img: "#" },
    { name: "Royal M5 TRẮNG ĐEN", price: "100.000 đ", img: "#" },
    { name: "MŨ BẢO HIỂM XE ĐẠP JC-20 HỒNG", price: "200.000 đ", img: "#" },
    { name: "MŨ BẢO HIỂM XE ĐẠP JC-20 CAM", price: "200.000 đ", img: "images/Mũ bảo hiểm xe đạp JC-20 Cam.jpg" },
    { name: "MŨ BẢO HIỂM XE ĐẠP JC-20 XANH", price: "200.000 đ", img: "#" },
    { name: "MŨ BẢO HIỂM XE ĐẠP JC-20 XANH", price: "200.000 đ", img: "#" },
    { name: "MŨ BẢO HIỂM XE ĐẠP JC-20 ĐỎ", price: "100.000 đ", img: "images/Mũ bảo hiểm xe đạp JC-20 Đỏ.jpg" },
    { name: "ROYAL M139 ĐỎ ĐÔ", price: "100.000 đ", img: "#" },
    { name: "ROYAL M139 V.5 ĐEN - ĐỒNG", price: "100.000 đ", img: "#" },
    { name: "ROYAL M139 V.7 VÀNG BÓNG", price: "100.000 đ", img: "#" },
    { name: "ROYAL M125K CHUỘT MỜ", price: "100.000 đ", img: "#" },
    { name: "ROYAL M139 XÁM XI MĂNG BÓNG", price: "100.000 đ", img: "#" },
    { name: "FULLFACE ROYAL M141K ĐEN BÓNG", price: "100.000 đ", img: "#" },
    { name: "FULLFACE ROYAL M02 SCHU ĐEN", price: "100.000 đ", img: "#" },
    { name: "FULLFACE ROYAL M141K TRẮNG", price: "100.000 đ", img: "#" },
    { name: "ROYAL M139 V.9 TRẮNG", price: "100.000 đ", img: "#" },
    { name: "FULLFACE ROYAL M02 ĐỎ", price: "100.000 đ", img: "#" },
    { name: "ASIA MT-10 ĐỎ MỜ", price: "100.000 đ", img: "images/2.1.2-Asia MT-10-Do-mo.jpg" },
    { name: "ASIA MT-10 XANH MU BÓNG", price: "100.000 đ", img: "#" },
    { name: "ASIA MT-10 XANH MU BÓNG", price: "100.000 đ", img: "#" },
    { name: "ASIA MT-10 XANH MU BÓNG", price: "100.000 đ", img: "#" },
];

searchInput.addEventListener("input", () => {
    const query = searchInput.value.toLowerCase().trim();
    searchResults.innerHTML = "";

    if (query) {
        const filteredProducts = productseach.filter(pross =>
            pross.name.toLowerCase().includes(query)
        );

        if (filteredProducts.length > 0) {
            filteredProducts.forEach(pross => {
                const li = document.createElement("li");
                li.innerHTML = `
                    <img src="${pross.img}" alt="${pross.name}">
                    <div>
                        <p>${pross.name}</p>
                        <p>${pross.price}</p>
                    </div>
                `;
                li.addEventListener("click", () => {
                    window.location.href = pross.url; // Chuyển hướng khi click
                });
                searchResults.appendChild(li);
            });
            searchResults.classList.remove("hidden");
        } else {
            searchResults.classList.add("hidden");
        }
    } else {
        searchResults.classList.add("hidden");
    }
});

// Đóng dropdown khi click bên ngoài
document.addEventListener("click", (e) => {
    if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
        searchResults.classList.add("hidden");
    }
});