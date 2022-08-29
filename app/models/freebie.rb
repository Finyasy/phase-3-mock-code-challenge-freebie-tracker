class Freebie < ActiveRecord::Base
    belongs_to :company
    belongs_to :dev

    # Freebie#dev returns the Dev instance for this Freebie
    def dev
        Dev.find(self.dev_id)
    end

    # Freebie#company returns the Company instance for this Freebie
    def company
        Company.find(self.company_id)
    end

    #  Freebie#print_details
    # should return a string formatted as follows: {insert dev's name} owns a {insert freebie's item_name} from {insert company's name}
    def print_details
        "#{self.dev.name} owns a #{self.item_name} from #{self.company.name}"
    end

end
