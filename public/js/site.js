document.addEventListener('DOMContentLoaded', () => {
    const navigation = document.querySelector('#mainNavigation');

    if (!navigation) {
        return;
    }

    navigation.querySelectorAll('.nav-link').forEach((link) => {
        link.addEventListener('click', () => {
            if (window.innerWidth < 992 && window.bootstrap) {
                window.bootstrap.Collapse.getOrCreateInstance(navigation).hide();
            }
        });
    });
});
