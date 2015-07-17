// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  //$("#avatar_file_reader").on("change", avatar_preview);
});

function avatar_preview() {
   // var files = !! this.files ? this.files : [];
    var files = !! $("#avatar_file_reader")[0].files ? $("#avatar_file_reader")[0].files : [];
  //alert($("#avatar_file_reader")[0].files);
    if (!files.length || !window.FileReader) return;
    //if (/^image/.test(files[0].type)) {
      var reader = new FileReader();
      reader.onload = function() {
        $("#avatar_pre_large").attr("src", reader.result);
        $("#avatar_pre_normal").attr("src", reader.result);
        $("#avatar_pre_small").attr("src", reader.result);
      }
      reader.readAsDataURL(files[0]);
 //   }
    $("#upload_button").fadeIn();
  }