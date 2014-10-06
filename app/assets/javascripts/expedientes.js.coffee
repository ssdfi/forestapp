$(document).on 'click', 'tr[data-link]', (evt) -> 
  window.location = this.dataset.link