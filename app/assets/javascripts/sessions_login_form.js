function transformFile() {
  var hidden_input = document.querySelector('#base64input');
  var file    = document.querySelector('input[type=file]').files[0];
  var reader  = new FileReader();

  reader.addEventListener("load", function () {
    hidden_input.value = reader.result.replace(/^data:;base64,/, "");
  }, false);

  if (file) {
    reader.readAsDataURL(file);
  }
}