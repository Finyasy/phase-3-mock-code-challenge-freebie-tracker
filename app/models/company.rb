class Company < ActiveRecord::Base
    has_many :freebies
    has_many :devs, through: :freebies

    # Company#freebies returns a collection of all the freebies for the Company
    def freebies
        Freebie.where(company_id: self.id)
    end

    # Company#devs returns a collection of all the devs who collected freebies from the Company
    def devs
        Dev.where(id: self.freebies.pluck(:dev_id))
    end

    # Company#give_freebie(dev, item_name, value)
    # takes a dev (an instance of the Dev class), an item_name (string), and a value as arguments, and creates a new Freebie instance associated with this company and the given dev
    def give_freebie(dev, item_name, value)
        Freebie.create(dev: dev, company: self, item_name: item_name, value: value)
    end

    # Company.oldest_company returns the Company instance with the earliest founding year
    def self.oldest_company
        Company.order(:founding_year).first
    end

    # Company.newest_company returns the Company instance with the latest founding year
    def self.newest_company
        Company.order(:founding_year).last
    end
end
