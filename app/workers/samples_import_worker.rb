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
      at(index)

      kismar = Festival.create!(samples["festivals"]["kismar"])
      index += 1
      at(index)

      ceda = kismar.schedulings.first.show_buyer
      ceda.update_attributes!(samples["show_buyers"]["ceda"])
      index += 1
      at(index)

      fly = Structure.create!(samples["structures"]["fly"])
      index += 1
      at(index)

      bob = olympiaf.people.first
      bob.update_attributes!(samples["people"]["bob"])
      index += 1
      at(index, "Bob importe")

      aurore = Person.create!(samples["people"]["aurore"])
      index += 1
      at(index, "Aurore Boreale Importe")
    rescue
      
    end
  end
end