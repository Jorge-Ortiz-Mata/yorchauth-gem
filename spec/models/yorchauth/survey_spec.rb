require 'rails_helper'

module Yorchauth
  RSpec.describe Survey, type: :model do
    let(:survey) { create :yorchauth_survey }

    describe 'instances' do
      it 'should be valid' do
        expect(survey).to be_valid
      end
    end
  end
end
