function pollJobidStatus() {
	var progressBarElement, progressBarSection, barElement, messageElement;
	progressBarElement = $("#progress_import")
	progressBarSection = progressBarElement.parent()
	json_path = progressBarElement.data("url")
	barElement = progressBarElement.find(".bar") 
	messageElement = progressBarElement.find(".message") 
  $.getJSON(json_path, function (response) {
    if (response.status == "working") {
    	barElement.width(response.pct + 1 + '%');
			if (response.message != null) {
				messageElement.empty()
				messageElement.append(response.message.replace(/\n/g, '<br />'))
			}
    }
    if (response.status == "complete") {
    	barElement.width('100%');
			if (response.result["message"] != null) {
				messageElement.empty()
				messageElement.append(response.result["message"].replace(/\n/g, '<br />'))
			}
	
			nb_imported_contacts = response.result["nb_imported_contacts"]
			nb_duplicates = response.result["nb_duplicates"]

			// progressBarSection.toggleClass("ghost");
			// $('#myModal').modal('toggle')
			console.log("result import:" + nb_imported_contacts + " / " + nb_duplicates + ":" + response.pct)
			// window.location = "<%= import_path(@job_id) %>"
			
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