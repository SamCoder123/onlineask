function initEditor() {
  var editor = new Simditor({
   textarea: $("#question_description"),
   toolbar: ['title', 'bold', 'italic', 'underline', 'strikethrough', 'color', '|', 'ol', 'ul', 'blockquote', 'code', 'table', 'link', '|','hr','indent','outdent','alignment'],
   placeholder: '想问的问题...',
   upload: {
     fileKey: 'file',
     params: null,
     connectionCount: 3,
     leaveConfirm: 'Uploading is in progress, are you sure to leave this page?'
   }
  });
  //editor.value();
}
