function post_favorite_twaat(twaat) {
  var request = new XMLHttpRequest();
  request.open('POST', 'favorite_twaat/'+twaat, true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
  request.send()
}

