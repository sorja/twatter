function post(url, data) {
  var request = new XMLHttpRequest();
  request.open('POST', url, true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
  request.send(data)
}

function post_favorite_twaat(twaat) {
  post('favorite_twaat/' + twaat, {})
}

function changeAvatar(e) {
  e.preventDefault()
  var modal = document.getElementById("upload_file");
  modal.className.split().map(function (e) { console.log(e) })
  modal.className += ' is-active'; // Click on the checkbox
}

function closeModal(e) {
  for (x of document.getElementsByClassName('modal')) {
    x.className = "modal";
  }
}

document.getElementById("change_avatar").addEventListener("click", changeAvatar);

/* Looks like getElementsByClassName returns a NODE __ LIST which obviously isnt AN ARRAY but a LIST -_- 
  so, cant map it or do nicely anything :c
*/


// for (x of document.getElementsByClassName("modal-background")){
//   x.addEventListener("click", closeModal);
// }
// for (x of document.getElementsByClassName("modal-close")){
//   x.addEventListener("click", closeModal);
// }

document.getElementsByClassName("modal-background")[0].addEventListener("click", closeModal);
document.getElementsByClassName("modal-close")[0].addEventListener("click", closeModal);