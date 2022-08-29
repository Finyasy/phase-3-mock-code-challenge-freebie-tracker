class Dev < ActiveRecord::Base
    has_many :freebies
    has_many :companies, through: :freebies

    # Dev#freebies returns a collection of all the freebies that the Dev has collected
    def freebies
        Freebie.where(dev_id: self.id)
    end

    # Dev#companies returns a collection of all the companies that the Dev has collected freebies from
    def companies
        Company.where(id: self.freebies.pluck(:company_id))
    end

    # Dev#received_one?(item_name)
    # accepts an item_name (string) and returns true if any of the freebies associated with the dev has that item_name, otherwise returns false
    def received_one?(item_name)
        self.freebies.each do |freebie|
            if freebie.item_name == item_name
                return true
            end
        end
        return false
    end

    # Dev#give_away(dev, freebie)
    # accepts a Dev instance and a Freebie instance, changes the freebie's dev to be the given dev; your code should only make the change if the freebie belongs to the dev who's giving it away
    def give_away(dev, freebie)
        if freebie.dev == self
            freebie.dev = dev
            freebie.save
        end
    end
end
