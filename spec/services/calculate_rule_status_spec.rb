require 'rails_helper'

describe CalculateRuleStatus do

  describe '.call' do
    it 'ok' do
      crc_eligible = create(:custom_rule_check, name: "crc1", result: "eligible")
      crc_ineligible = create(:custom_rule_check, name: "crc2",  result: "ineligible")
      rule = create(:rule, :be_an_adult_or_a_spectacles, name: "to_be_tested", custom_rule_checks: [crc_eligible, crc_ineligible])
      sut = CalculateRuleStatus.new.call(rule)
      expect(sut).to eq("ok")
    end
    it 'missing_simulation' do
      rule = create(:rule, :be_an_adult_or_a_spectacles, name: "not_simulated")
      sut = CalculateRuleStatus.new.call(rule)
      expect(sut).to eq("missing_simulation")
    end
    it 'missing_eligible' do
      crc_ineligible = create(:custom_rule_check, name: "crc2",  result: "ineligible")
      rule = create(:rule, :be_an_adult_or_a_spectacles, name: "eligible_missing", custom_rule_checks: [crc_ineligible])
      sut = CalculateRuleStatus.new.call(rule)
      expect(sut).to eq("missing_eligible")
    end
    it 'missing_ineligible' do
      crc_eligible = create(:custom_rule_check, name: "crc2",  result: "eligible")
      rule = create(:rule, :be_an_adult_or_a_spectacles, name: "ineligible_missing", custom_rule_checks: [crc_eligible])
      sut = CalculateRuleStatus.new.call(rule)
      expect(sut).to eq("missing_ineligible")
    end    
    it 'wrong input' do
      sut = CalculateRuleStatus.new.call(42)
      expect(sut).to eq("")
    end    
  end
end
