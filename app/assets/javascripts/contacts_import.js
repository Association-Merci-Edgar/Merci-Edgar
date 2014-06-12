function pollJobidStatus() {
	var progressBarElement, progressBarSection, barElement, messageElement;
	progressBarElement = $("#progress_import")
	progressBarSection = progressBarElement.parent()
	json_path = progressBarElement.data("url")
	barElement = progressBarElement.find(".bar") 
	//messageElement = progressBarElement.find(".message") 
  messageElement = $("#log_import") 
 
	$.getJSON(json_path, function (response) {
    if (response.status == "working") {
    	barElement.width(response.pct + 1 + '%');
			if (response.message != null) {
				messageElement.empty()
				messageElement.append(response.message.replace(/\n/g, '<br />'))
			}
    }
    if (response.status == "complete") {
			if (response.result["invalid_file"] != null) {
				showNoticeError(response.result["message"],"", true)
				return false;
			}
			if (response.result["message"] != null) {
				messageElement.empty()
				messageElement.append(response.result["message"].replace(/\n/g, '<br />'))
			}
	
			nb_imported_contacts = response.result["nb_imported_contacts"]
			nb_duplicates = response.result["nb_duplicates"]

			showNoticeSuccessSection("toto.csv", nb_imported_contacts, "toto")
			
			return false;
    }
		if (response.status == "failed") {
			showNoticeError("Une erreur interne est survenue", response.message, false)
			return false;
		}

    setTimeout(pollJobidStatus, 1000);
  });
};
pollJobidStatus();

function showNoticeError(short_message, trace_message, hide_log_import) {
	$("#progress_section").hide()
	if (hide_log_import) { $("#log_import").hide() }
	$("#short_message").text(short_message)
	$("#exception_message").text(trace_message)
	$("#notice_error").show()	
}
function showNoticeSuccessSection(filename, nb_imported_contacts, contacts_url) {
	progressSection = $("#progress_section")
	noticeSuccessSection = $("#notice_success")
	nbImportedContactsSpan = $("#notice_success #nb_imported_contacts")
	
	nbImportedContactsSpan.text(nb_imported_contacts)
	progressSection.fadeOut()
	noticeSuccessSection.fadeIn()
}