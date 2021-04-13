function text_copy() {
  
  const copyText = document.getElementById('copy-text');
  const copyBtn = document.getElementById('copy-btn');
  
  copyBtn.addEventListener('click', function(e){
    copyText.select();
    document.execCommand("copy");
  })
}
if(document.URL.match(/transcripts/)){
  window.addEventListener('load', text_copy)
}