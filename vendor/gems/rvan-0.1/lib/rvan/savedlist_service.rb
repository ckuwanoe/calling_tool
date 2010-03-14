module VAN
  class SavedListResponse < Response
    def saved_list_id
       parsed_xml["Body"]["ListSavedListsResponse"]["ListSavedListsResult"]["SavedListID"]      
    end
  end
  
  class SavedListService < Service

    def initialize(api_key, options = {})
      super(api_key, "/Services/V3/SavedListService.asmx", options = {})
    end
    
    def list_saved_lists
      message = create_message("MyCampaign") do |xml|
        xml.ListSavedLists 'xmlns' => "https://api.securevan.com/Services/V3/" do |xml|
          #xml.FolderID("EID4D3L")
          xml.options do
            xml.ReturnSections("User")
          end
        end
      end
      
      #SavedListResponse.new(make_request('ListSavedLists', message).body)      
    end
    
    def get_saved_list(savedlist_id)
      message = create_message("MyCampaign") do |xml|
        xml.GetSavedList 'xmlns' => "https://api.securevan.com/Services/V3/" do |xml|
          xml.SavedListID(savedlist_id)
          xml.options do
            xml.ReturnSections("User,Folder,Data")
          end
        end
      end
    end
    
    def create_saved_list(name)
      message = create_message("MyCampaign") do |xml|
        xml.CreateSavedList 'xmlns' => "https://api.securevan.com/Services/V3/" do |xml|
          xml.Name(name)
        end
      end      
    end
    
  end
end