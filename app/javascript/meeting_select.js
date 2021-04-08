function list_select(meetingRecordSelected) {

  const meetingRecordAll = document.querySelectorAll('.meeting-record');

  meetingRecordAll.forEach(function(meetingRecord){
    meetingRecord.classList.remove('selected'); //一旦全てのmeetingRecordから、selectedを外す
    meetingRecordSelected.classList.add('selected'); //選択（クリック）したmeetingRecordにのみ、selectedを付与する
  })
  return meetingRecordSelected.getAttribute('id').replace('meeting-id-',''); //選択（クリック）したmeetingRecordのid取得
}

function meetingSelect() {

  const meetingRecordCreate = document.querySelectorAll('.meeting-record-create');
  const meetingRecordShow = document.querySelectorAll('.meeting-record-show');
  const editBtn = document.getElementById('edit-btn');
  const editBtnLink = document.getElementById('edit_btn_link');
  const deleteBtn = document.getElementById('delete-btn');
  const deleteBtnLink = document.getElementById('delete_btn_link');
  const accessPremitBtn = document.getElementById('access-permit-btn');
  const accessPremitBtnLink = document.getElementById('access_permit_btn_link');
  const showBtn = document.getElementById('show-btn');
  const showBtnLink = document.getElementById('show_btn_link');

  //自分が作成した議事録を選択した場合
  meetingRecordCreate.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      let recordId = list_select(meetingRecordSelected);
      //編集、削除、共有設定、閲覧ボタンが活性化
      editBtn.classList.remove('disabled');
      deleteBtn.classList.remove('disabled');
      accessPremitBtn.classList.remove('disabled');
      showBtn.classList.remove('disabled');
      //編集、削除、共有設定、閲覧ボタンのリンク設定
      editBtnLink.removeAttribute("href");
      editBtnLink.setAttribute("href", `/meetings/${recordId}/edit`);
      deleteBtnLink.removeAttribute("href");
      deleteBtnLink.setAttribute('href', `/meetings/${recordId}`);
      accessPremitBtnLink.removeAttribute("href");
      accessPremitBtnLink.setAttribute('href', `/meetings/${recordId}/access_permits`);
      showBtnLink.removeAttribute("href");
      showBtnLink.setAttribute("href", `/meetings/${recordId}`);
    })
  })

  //閲覧許可された議事録を選択した場合
  meetingRecordShow.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      let recordId = list_select(meetingRecordSelected);
      //編集、削除、共有設定ボタンが不活性化
      editBtn.classList.add('disabled');
      deleteBtn.classList.add('disabled');
      accessPremitBtn.classList.add('disabled');
      //閲覧ボタンが活性化
      showBtn.classList.remove('disabled');
      //編集、削除、共有設定ボタンのリンク削除
      editBtnLink.removeAttribute("href");
      deleteBtnLink.removeAttribute("href");
      accessPremitBtnLink.removeAttribute("href");
      //閲覧ボタンのリンク設定
      showBtnLink.removeAttribute("href");
      showBtnLink.setAttribute("href", `/meetings/${recordId}`);
    })
  })
}

window.addEventListener('load', meetingSelect)