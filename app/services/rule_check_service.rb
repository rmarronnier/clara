class RuleCheckService
  include Rails.application.routes.url_helpers

  def check_type(rule)
    state = 'error'
    if rule.variable.present?
      if rule.variable.variable_kind == 'integer'
        state='ok' if !!( rule.value_eligible.match /^(\d)+$/ )
      elsif rule.variable.variable_kind == 'string'
        state = 'ok' if rule.value_eligible != ''
      elsif rule.variable.variable_kind == 'selectionnable'
        array_of_possibilities = extract_descriptions(rule)
        state = 'ok' if array_of_possibilities.include?(rule.value_eligible)
      end
    else
      state='n/a'
    end
    state
  end
  
  def check_custom_rule(rule, all_rules_composition)
    rule.custom_rule_checks.each do |c|
      local_result = RuletreeService.new.resolve(rule.id, c.hsh)  
      final_result = local_result.to_s == c.result.to_s ? 'ok' : 'error'
      all_rules_composition << { type: '3-custom', name: rule.name, result: final_result, link: edit_admin_rule_path(rule.id), description: c.name }
    end
  end

private
  def extract_descriptions(rule)
    res = []
    begin
      res = rule.variable.elements.split(',').map {|e| e.strip}
    rescue Exception => e
      res = []
    end
    res
  end
  
end
