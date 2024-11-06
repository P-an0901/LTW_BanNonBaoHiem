/* Ngăn hành động mục có dropdown*/
const menuLinks = document.querySelectorAll('.menu-link');
    const submenuItems = document.querySelectorAll('.menu-list-item');

    menuLinks.forEach(link => {
        link.addEventListener('click', function(event) {
                menuLinks.forEach(link => {
                    link.classList.remove('active');
                });
                this.classList.add('active');
        });
});