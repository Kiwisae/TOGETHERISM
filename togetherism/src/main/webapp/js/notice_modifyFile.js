$.ajax({
	type="POST",
	url:"notice_modifyFile.do",
	data: {"modifyFile":modifyFile},
	success: function (data) {
		location.reload();
		}
});