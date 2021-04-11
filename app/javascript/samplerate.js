function samplerate() {
  
  const transcriptVoiceData = document.getElementById('transcript-voice-data');
  //音声ファイルのサンプリングレートをhidden属性で送信する
  transcriptVoiceData.addEventListener('input', function(e){
    let context = new AudioContext(e.target.files[0]);
    let html = `<input value="${context.sampleRate}" type="hidden" name="transcript[samplerate]">`;
    this.insertAdjacentHTML("afterEnd",html);
  })
}

window.addEventListener('load', samplerate)