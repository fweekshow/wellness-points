// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Profile dropdown toggle

document.addEventListener('DOMContentLoaded', function() {
  var trigger = document.querySelector('.profile-dropdown-trigger');
  var dropdown = document.querySelector('.profile-dropdown');
  var container = document.querySelector('.profile-dropdown-container');

  if (trigger && dropdown && container) {
    trigger.addEventListener('click', function(e) {
      e.stopPropagation();
      var isOpen = dropdown.style.display === 'block';
      dropdown.style.display = isOpen ? 'none' : 'block';
      trigger.setAttribute('aria-expanded', !isOpen);
    });

    document.addEventListener('click', function(e) {
      if (!container.contains(e.target)) {
        dropdown.style.display = 'none';
        trigger.setAttribute('aria-expanded', false);
      }
    });
  }
});
