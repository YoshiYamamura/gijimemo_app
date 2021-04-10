function list_select(meetingRecordSelected) {

  const meetingRecordAll = document.querySelectorAll('.meeting-record');

  meetingRecordAll.forEach(function(meetingRecord){
    meetingRecord.classList.remove('selected'); //一旦全てのmeetingRecordから、selectedを外す
    meetingRecordSelected.classList.add('selected'); //選択（クリック）したmeetingRecordにのみ、selectedを付与する
  })
  return meetingRecordSelected.getAttribute('id').replace('meeting-id-','').replace('transcript-id-',''); //選択（クリック）したRecordのid取得
}

function meetingSelect() {

  const meetingRecordCreate = document.querySelectorAll('.meeting-record-create');
  const meetingRecordShow = document.querySelectorAll('.meeting-record-show');
  const transcriptRecord = document.querySelectorAll('.transcript-record');
  const editBtn = document.getElementById('edit-btn');
  const editBtnLink = document.getElementById('edit_btn_link');
  const deleteBtn = document.getElementById('delete-btn');
  const deleteBtnLink = document.getElementById('delete_btn_link');
  const accessPremitBtn = document.getElementById('access-permit-btn');
  const accessPremitBtnLink = document.getElementById('access_permit_btn_link');
  const showMeetingBtn = document.getElementById('show-meeting-btn');
  const showMeetingBtnLink = document.getElementById('show_meeting_btn_link');
  const showTranscriptBtn = document.getElementById('show-transcript-btn');
  const showTranscriptBtnLink = document.getElementById('show_transcript_btn_link');

  //自分が作成した議事録を選択した場合
  meetingRecordCreate.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      let recordId = list_select(meetingRecordSelected);
      //議事録:編集、削除、共有設定、閲覧ボタンが活性化
      editBtn.classList.remove('disabled');
      deleteBtn.classList.remove('disabled');
      accessPremitBtn.classList.remove('disabled');
      showMeetingBtn.classList.remove('disabled');
      //文字起こしデータ:閲覧ボタンが不活性化
      showTranscriptBtn.classList.add('disabled');
      //議事録:編集、削除、共有設定、閲覧ボタンのリンク設定
      editBtnLink.removeAttribute("href");
      editBtnLink.setAttribute("href", `/meetings/${recordId}/edit`);
      deleteBtnLink.removeAttribute("href");
      deleteBtnLink.setAttribute('href', `/meetings/${recordId}`);
      accessPremitBtnLink.removeAttribute("href");
      accessPremitBtnLink.setAttribute('href', `/meetings/${recordId}/access_permits`);
      showMeetingBtnLink.removeAttribute("href");
      showMeetingBtnLink.setAttribute("href", `/meetings/${recordId}`);
      //文字起こしデータ:閲覧ボタンのリンク削除
      showTranscriptBtnLink.removeAttribute("href");
    })
  })

  //閲覧許可された議事録を選択した場合
  meetingRecordShow.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      let recordId = list_select(meetingRecordSelected);
      //議事録:編集、削除、共有設定ボタン,文字起こしデータ:閲覧ボタンが不活性化
      editBtn.classList.add('disabled');
      deleteBtn.classList.add('disabled');
      accessPremitBtn.classList.add('disabled');
      showTranscriptBtn.classList.add('disabled');
      //議事録:閲覧ボタンが活性化
      showMeetingBtn.classList.remove('disabled');
      //議事録:編集、削除、共有設定ボタン,文字起こしデータ:閲覧ボタンのリンク削除
      editBtnLink.removeAttribute("href");
      deleteBtnLink.removeAttribute("href");
      accessPremitBtnLink.removeAttribute("href");
      showTranscriptBtnLink.removeAttribute("href");
      //議事録:閲覧ボタンのリンク設定
      showMeetingBtnLink.removeAttribute("href");
      showMeetingBtnLink.setAttribute("href", `/meetings/${recordId}`);
    })
  })

  //文字起こしデータを選択した場合
  transcriptRecord.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      let recordId = list_select(meetingRecordSelected);
      //議事録:編集、削除、共有設定、閲覧ボタンが不活性化
      editBtn.classList.add('disabled');
      deleteBtn.classList.add('disabled');
      accessPremitBtn.classList.add('disabled');
      showMeetingBtn.classList.add('disabled');
      //文字起こしデータ:閲覧ボタンが活性化
      showTranscriptBtn.classList.remove('disabled');
      //議事録:編集、削除、共有設定、閲覧ボタンのリンク削除
      editBtnLink.removeAttribute("href");
      deleteBtnLink.removeAttribute("href");
      accessPremitBtnLink.removeAttribute("href");
      showMeetingBtnLink.removeAttribute("href");
      //文字起こしデータ:閲覧ボタンのリンク設定
      showTranscriptBtnLink.removeAttribute("href");
      showTranscriptBtnLink.setAttribute("href", `/transcripts/${recordId}`);
    })
  })
}

window.addEventListener('load', meetingSelect)