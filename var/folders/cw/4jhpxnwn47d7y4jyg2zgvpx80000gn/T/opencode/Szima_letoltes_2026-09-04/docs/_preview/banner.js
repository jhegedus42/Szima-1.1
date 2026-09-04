(function(){
  var m = null;
  fetch('/adatok/preview_meta.json').then(function(r){ return r.json(); }).then(function(j){
    m = j;
    var b = document.createElement('div');
    b.id = 'preview-ag-banner';
    if (j.kornyezet === 'production') b.className = 'production';
    b.innerHTML = '<span><strong>Docs preview</strong></span>'
      + '<span class="tag">ág: ' + j.ag + '</span>'
      + '<span class="tag">' + j.commit_rovid + '</span>'
      + '<span>' + j.kornyezet + '</span>'
      + '<a href="https://github.com/jhegedus42/Szima/tree/' + encodeURIComponent(j.ag) + '/docs" target="_blank" rel="noopener">GitHub docs/</a>'
      + '<a href="literatura.html">Térkép</a>';
    document.body.classList.add('has-preview-banner');
    document.body.appendChild(b);
  }).catch(function(){});
})();
