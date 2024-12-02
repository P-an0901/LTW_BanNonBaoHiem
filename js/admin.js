const sidebars = document.querySelectorAll(".sidebar-list-item.tab-content");
const sections = document.querySelectorAll(".section");

for(let i = 0; i < sidebars.length; i++) {
    sidebars[i].onclick = function () {
        document.querySelector(".sidebar-list-item.active").classList.remove("active");
        document.querySelector(".section.active").classList.remove("active");
        sidebars[i].classList.add("active");
        sections[i].classList.add("active");
    };
}
document.addEventListener("DOMContentLoaded", function () {
    const table1 = document.getElementById("product-table");
    const table2 = document.getElementById("variant-content");
    const dataTable = new DataTable(table1, {
        "paging": true,
        "searching": false, 
        "ordering": true,  
        "info": false,  
        "lengthChange": false, 
        "pageLength": 3,    
    });
});

document.addEventListener('DOMContentLoaded', function () {
    // Dữ liệu mẫu cho biến thể
    const variantData = {
        1: [
            { id: 1, name: "Royal M139 Trắng", color: "Trắng", price: "100,000 VND", image: "images/Royal-M139-V.10-Trang.jpg" },
            { id: 2, name: "Royal M139 Trắng Đen", color: "Trắng Đen", price: "150,000 VND", image: "images/Royal-M139-V.5-Trang-den.jpg" },
        ],
        2: [
            { id: 1, name: "Biến thể X", color: "Vàng", price: "200,000 VND", image: "link-to-image.jpg" },
        ],
        3: [
            { id: 1, name: "Biến thể Z", color: "Đen", price: "300,000 VND", image: "link-to-image.jpg" },
            { id: 2, name: "Biến thể Y", color: "Trắng", price: "250,000 VND", image: "link-to-image.jpg" },
        ],
    };
    const table2 = document.getElementById("variant-content");
            const variantDataTable = new DataTable(table2, {
                "paging": true,
                "searching": false, 
                "ordering": true,  
                "info": false,  
                "lengthChange": false,
                "pageLength": 3,    
            });

    // Xử lý khi nhấn nút Chi tiết
    document.querySelectorAll('.variant-btn').forEach(button => {
        button.addEventListener('click', function () {
            const productId = this.getAttribute('data-id');
            const variants = variantData[productId] || [];

            const variantTableBody = document.querySelector('#variant-content tbody');
            variantTableBody.innerHTML = ''; 
            variants.forEach((variant, index) => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${index + 1}</td>
                    <td>${variant.name}</td>
                    <td><img src="${variant.image}" alt="${variant.name}" width="50"></td>
                    <td>${variant.color}</td>
                    <td>${variant.price}</td>
                    <td><button class="details-btn" data-id="3"><i class="fa-solid fa-eye"></i></button></td>
                    <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                    <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                `;
                variantTableBody.appendChild(row);
            });
            variantDataTable.clear();
            variantDataTable.rows.add(variantTableBody.rows); 
            variantDataTable.draw();
        });
    });
});

