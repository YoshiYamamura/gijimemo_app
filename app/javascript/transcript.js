function transcript() {
  
  const transcriptVoiceData = document.getElementById('transcript-voice-data');
  const audioPlayer = document.getElementById('audio-player');
  const audioDuration =  document.getElementById('audio-duration');

  //音声データ読み込み
  transcriptVoiceData.addEventListener('input', function(e){
    let file = e.target.files[0];
    //オーディオプレイヤーへの挿入
    let blob = URL.createObjectURL(file);
    audioPlayer.setAttribute("src", blob);
    //長さの取得送信
    audioPlayer.addEventListener('loadedmetadata',function(audio) {
      let audio_duration = audio.target.duration;
      audioDuration.value = audio_duration;
    });
  })

}
if(document.URL.match(/transcripts\/new/)){
  window.addEventListener('load', transcript)
}