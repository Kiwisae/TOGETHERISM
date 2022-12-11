ClassicEditor
.create( document.querySelector( '#notice_content' ), {
	
	//이미지 업로드 기능 제거
	removePlugins: [ 'ImageUpload' ]

	} )
	.catch( error => {
		console.error( error );
	} );