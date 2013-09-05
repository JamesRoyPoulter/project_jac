$('#new_person_picture .button').click ()->
  $('#person_picture').click()

$('#person_picture').change ()->
  x = new RegExp(/^[a-zA-Z]*/)
  if x.exec(this.files[0].type)[0] is 'image'
    Ehxe.File.previewImage("#edit_person_picture", this)
  else
    alert 'Invalid File Type'
    delete this.files[0]

