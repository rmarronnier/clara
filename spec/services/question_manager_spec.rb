require 'rails_helper'

feature QuestionManager do 

  URL_PREFIX = 'http://mydomain:3000'

  describe '.getNextPath' do 
    
    context 'Empty args' do
      subject { QuestionManager.new.getNextPath }
      context 'go to inscription screen by default' do
        let(:target) { new_inscription_question_path }
        it { expect(subject).to eq target}
      end
    end
    
    context 'Non empty arg' do

      subject { QuestionManager.new.getNextPath(referer, form) }


      context 'go from inscription to category, by default' do
        let(:referer) { 'inscription' }
        let(:form) { Struct.new(:value).new('') }
        it { expect(subject).to eq new_category_question_path }
      end
      context 'go from inscription to allocation, if no-subscription' do
        let(:referer) { 'inscription' }
        let(:form) { Struct.new(:value).new('non_inscrit') }
        it { expect(subject).to eq new_allocation_question_path }
      end
      context 'go from category to allocation' do
        let(:referer) { 'category' }
        let(:form) { Struct.new(:value).new('') }
        it { expect(subject).to eq new_allocation_question_path }
      end
      context 'go from allocation to age, by default' do
        let(:referer) { 'allocation' }
        let(:form) { Struct.new(:type).new('') }
        it { expect(subject).to eq new_age_question_path }
      end
      context 'go from allocation to A.R.E, if type of allocation is "ASS_AER_APS_AS-FNE"' do
        let(:referer) { 'allocation' }
        let(:form) { Struct.new(:type).new('ASS_AER_APS_AS-FNE') }
        it { expect(subject).to eq new_are_question_path }
      end
      context 'go from allocation to A.R.E, if type of allocation is "ARE_ASP"' do
        let(:referer) { 'allocation' }
        let(:form) { Struct.new(:type).new('ARE_ASP') }
        it { expect(subject).to eq new_are_question_path }
      end
      context 'go from A.R.E to age' do
        let(:referer) { 'are' }
        let(:form) { Struct.new(:type).new('') }
        it { expect(subject).to eq new_age_question_path }
      end   
      context 'go from age to grade' do
        let(:referer) { 'age' }
        let(:form) { Struct.new(:type).new('') }
        it { expect(subject).to eq new_grade_question_path }
      end 
      context 'go from grade to address' do
        let(:referer) { 'grade' }
        let(:form) { Struct.new(:type).new('') }
        it { expect(subject).to eq new_address_question_path }
      end 
      context 'go from address to other' do
        let(:referer) { 'address' }
        let(:form) { Struct.new(:value).new('') }
        it { expect(subject).to eq new_other_question_path }
      end
      context 'go from other to results' do
        let(:referer) { 'other' }
        let(:form) { 'the_id' }
        it { expect(subject).to eq '/aides?for_id=the_id' }
      end 
    end

  end

  describe '.getPreviousPath' do 

    subject { QuestionManager.new.getPreviousPath(referer, asker) }

    let(:asker) { Asker.new  }
    
    context 'go from other back to address page' do
      let(:referer) { 'other' }
      it { expect(subject).to eq new_address_question_path }
    end

    context 'go from address back to grade page' do
      let(:referer) { 'address' }
      it { expect(subject).to eq new_grade_question_path }
    end

    context 'go from grade back to age page' do
      let(:referer) { 'grade' }
      it { expect(subject).to eq new_age_question_path }
    end

    context 'go from age back to A.R.E, if asker has are' do
      let(:asker) { Asker.new(v_allocation_value_min: "320") }
      let(:referer) { 'age' }
      it { expect(subject).to eq new_are_question_path }
    end

    context 'go from age back to allocation, if asker has are that is not an integer' do
      let(:asker) { Asker.new(v_allocation_value_min: "verybadinput") }
      let(:referer) { 'age' }
      it { expect(subject).to eq new_allocation_question_path }
    end

    context 'go from age back to allocation, if asker has NO are' do
      let(:referer) { 'age' }
      it { expect(subject).to eq new_allocation_question_path }
    end

    context 'go from A.R.E back to allocation page' do
      let(:referer) { 'are' }
      it { expect(subject).to eq new_allocation_question_path }
    end
    
    context 'go from allocation back to category page' do
      let(:referer) { 'allocation' }
      it { expect(subject).to eq new_category_question_path }
    end

    context 'go from allocation back to inscription page, if category is not applicable' do
      let(:asker) { Asker.new(v_category: 'not_applicable') }
      let(:referer) { 'allocation' }
      it { expect(subject).to eq new_inscription_question_path }
    end

    context 'go from category back to inscription page' do
      let(:referer) { 'category' }
      it { expect(subject).to eq new_inscription_question_path }
    end

    context 'go from inscription back to index page' do
      let(:referer) { 'inscription' }
      it { expect(subject).to eq root_path }
    end

  end

end

