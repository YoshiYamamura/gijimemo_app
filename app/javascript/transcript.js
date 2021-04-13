function transcript() {
  
  const transcriptVoiceData = document.getElementById('transcript-voice-data');
  const audioPlayer = document.getElementById('audio-player');
  const sampleRate = document.getElementById('sample-rate');
  const sampleRateKhz = document.getElementById('sample-rate-khz');

  //オーディオプレイヤー
  transcriptVoiceData.addEventListener('input', function(e){
    let file = e.target.files[0];
    let blob = URL.createObjectURL(file);
    audioPlayer.setAttribute("src", blob);
  })

  //サンプリングレートのkHz表示
  sampleRate.addEventListener('keyup', function(){
    let input = this.value;
    sampleRateKhz.innerHTML = ` Hz(${input / 1000}kHz)` ;
  })
}
if(document.URL.match(/transcripts\/new/)){
  window.addEventListener('load', transcript)
}