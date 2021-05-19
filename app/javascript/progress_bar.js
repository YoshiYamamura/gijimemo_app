function get_seconds(input) {
  let time = input.split(':'); //時、分、秒が配列として格納される
  return time[0]*24*60 + time[1]*60 + time[2]*1;
}

function progress_bar() {
  
  const transcriptRecords = document.querySelectorAll('.transcript-record');
  const dateNow = new Date();
  let progress_percents = [];
  let i = 0;

  transcriptRecords.forEach(function(transcriptRecord){
    let recordId = transcriptRecord.getAttribute('id').replace('transcript-id-','');
    let progressBar = document.getElementById(`progress-id-${recordId}`);
    if(progressBar != null){
      //完了予想時刻、開始時刻の読み取り
      let times = progressBar.innerHTML.split('/');
      let expectedTime = times[0].replace('完了予想時刻：','')
      let startTime = times[1].replace('開始時刻：','')
      //秒時間の算出
      let startTimeSeconds = get_seconds(startTime);
      let expectedTimeSeconds = get_seconds(expectedTime);
      let passedTimeSeconds = dateNow.getHours()*24*60 + dateNow.getMinutes()*60 + dateNow.getSeconds()*1;
      //日を跨いだ場合
      if (startTimeSeconds > expectedTimeSeconds) {
        expectedTimeSeconds += 24*60*60;
      }
      if (startTimeSeconds > passedTimeSeconds) {
        passedTimeSeconds += 24*60*60;
      }
      //予想進捗率
      let duration = expectedTimeSeconds - startTimeSeconds;
      progress_percents[i] = (passedTimeSeconds - startTimeSeconds) * 100 / duration;
      if (progress_percents[i] > 100) {
        progress_percents[i] = 100
      }
      progressBar.setAttribute("value", progress_percents[i]);
      i++;
    }
  })
  //もし全てのプログレスバーが進捗率100％になっていなければ繰り返し
  let total = 0;
  progress_percents.forEach(function(progress_percent){
    total += progress_percent;
  })
  if (total / i < 100){
    setTimeout(progress_bar, 100);
  }else{
    console.log("done!");
  }
}

window.addEventListener('load', function(){
  const progressBars = document.getElementsByTagName('progress')
  if(progressBars.length > 0){
    progress_bar();
  }
})