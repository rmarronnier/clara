  class RoutesList
    
    def self.questions
      all_pathes.select {|key| key.to_s.include?('_question')}      
    end    

    def self.asked_questions
      questions.select {|key| key.to_s.start_with?('new_')}      
    end  

    def self.not_questions
      all_pathes.reject {|key| key.to_s.include?('_question')}      
    end    

    def self.all_routes
      Hash[Rails.application.routes.routes.map { |r| [r.name, r.path.spec.to_s] }].transform_values{ |e| e.gsub("(.:format)", "")}
    end    

    def self.all_pathes
      all_routes.transform_keys{ |key| key.to_s + '_path' }
    end    

  end
