// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-switch
//= require jquery_nested_form

/*
 * Define los valores por defecto de Bootstrap Switch
 */
$.fn.bootstrapSwitch.defaults.onText = 'Sí';
$.fn.bootstrapSwitch.defaults.offText = 'No';
$.fn.bootstrapSwitch.defaults.labelWidth = '150';

/*
 * Convierte todos los checkbox en switch
 */
$(function() {
  $("input[data-label]").each(function () {
    $(this).bootstrapSwitch({labelText: this.dataset.label});
  })
});

/**
 * Define el método click para redirigir a la url definida en la propiedad data-link al hacer click en un <tr>
 * que contenga dicha propiedad.
 */
$(function() {
  $("tr[data-link]").click(function () {
    window.location = this.dataset.link
  })
});

/**
 * Trunca el texto de todos los tags <abbr> si el largo supera la cantidad de caracteres definido en la propiedad
 * data-length. El texto utilizado se define en la propiedad data-title. Si la propiedad data-length no está
 * definida, se trunca el texto si la cantidad de caracteres es mayor a 8.
 */
$(function() {
  $("abbr").each(function () {
    text = $(this).prop("title")
    length = parseInt(this.dataset.length) || 8
    if (text.length > length) {
      text = text.substring(0, length)
      $(this).text(text)
    } else {
      $(this).parent().text(text);
    }
  })
});

/**
 * Cierra automáticamente los mensajes informativos
 */
setTimeout(function() {
  $(".alert.alert-info").slideUp(1500, 0, function() {
    $(this).remove();
  }
)}, 4000)