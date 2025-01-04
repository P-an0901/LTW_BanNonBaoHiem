$(document).ready(function() {
    $('#edit-info-btn').click(function () {
        $('#editInfoModal').modal('show')
    });
    $('#change-password-btn').click(function () {
        $('#changePasswordModal').modal('show')
    });
    $('#delete-account-btn').click(function () {
        $('#deleteAccountModal').modal('show')
    });
});

const extraOrders = document.querySelectorAll('.extra-order');
    const loadMoreBtn = document.getElementById('load-more');
    const hideBtn = document.getElementById('hide-extra');
    
    for (let i = 3; i < extraOrders.length; i++) {
        extraOrders[i].style.display = 'none';
    }

    loadMoreBtn.addEventListener('click', function() {
        extraOrders.forEach(order => {
            order.style.display = 'table-row'; 
        });
        loadMoreBtn.style.display = 'none';  
        hideBtn.style.display = 'inline-block'; 
    });

    hideBtn.addEventListener('click', function() {
        for (let i = 3; i < extraOrders.length; i++) {
            extraOrders[i].style.display = 'none'; 
        }
        loadMoreBtn.style.display = 'inline-block'; 
        hideBtn.style.display = 'none'; 
    });
    function toggleDetails(button) {
        const row = button.closest('tr'); 
        const detailsRow = row.nextElementSibling;  
        if (detailsRow.style.display === 'none') {
            detailsRow.style.display = 'table-row';  
        } else {
            detailsRow.style.display = 'none';  
        }
    }