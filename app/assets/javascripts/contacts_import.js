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
			barElement.width("0%")
			messageElement.text("FAILED")
			// $('#myModal .errors').append("<div class='notice error'>Un problème est survenu. Edgar est averti !</div>")
			return
		}

    setTimeout(pollJobidStatus, 1000);
  });
};
pollJobidStatus();

function showNoticeSuccessSection(filename, nb_imported_contacts, contacts_url) {
	progressSection = $("#progress_section")
	noticeSuccessSection = $("#notice_success")
	nbImportedContactsSpan = $("#notice_success #nb_imported_contacts")
	
	nbImportedContactsSpan.text(nb_imported_contacts)
	progressSection.fadeOut()
	noticeSuccessSection.fadeIn()
}