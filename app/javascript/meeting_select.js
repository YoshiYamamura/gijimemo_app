function meetingSelect() {

  const meetingRecordAll = document.querySelectorAll('.meeting-record');
  const editBtn = document.getElementById('edit-btn');
  const editBtnLink = document.getElementById('edit_btn_link');
  const deleteBtn = document.getElementById('delete-btn');
  const deleteBtnLink = document.getElementById('delete_btn_link');
  const accessPremitBtn = document.getElementById('access-permit-btn');
  const accessPremitBtnLink = document.getElementById('access_permit_btn_link');
  const showBtn = document.getElementById('show-btn');
  const showBtnLink = document.getElementById('show_btn_link');

  meetingRecordAll.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      meetingRecordAll.forEach(function(meetingRecord){
        //一旦全てのmeetingRecordから、selectedを外す
        meetingRecord.classList.remove('selected');
        //選択（クリック）したmeetingRecordにのみ、selectedを付与する
        meetingRecordSelected.classList.add('selected');
        //選択（クリック）したmeetingRecordのid取得
        let recordId = meetingRecordSelected.getAttribute('id').replace('meeting-id-','');
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
  })
}

window.addEventListener('load', meetingSelect)