class SamplesImportWorker
  include SidekiqStatus::Worker

  def perform(account_id)
    begin
      Account.current_id = account_id
      logger.info "Import samples into #{Account.current_id}"


      samples = YAML.load(File.open("config/sample_data.yml"))
      self.total = 6
      index = 0

      olympiaf = Venue.create!(samples["venues"]["olympiaf"])
      index += 1
      at(index, "Salle Olympiaf importée")

      kismar = Festival.create!(samples["festivals"]["kismar"])
      index += 1
      at(index, "Festival Kismar importé")

      ceda = kismar.schedulings.first.show_buyer
      ceda.update_attributes!(samples["show_buyers"]["ceda"])
      index += 1
      at(index)

      fly = Structure.create!(samples["structures"]["fly"])
      index += 1
      at(index, "Structure CEDA importée")

      bob = olympiaf.people.first
      bob.update_attributes!(samples["people"]["bob"])
      index += 1
      at(index, "Bob importé")

      aurore = Person.create!(samples["people"]["aurore"])
      index += 1
      at(index, "Aurore Boreale importée")
    rescue
      
    end
  end
end