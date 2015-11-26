require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end
    it 'returns five black stars for five' do
    	expect(helper.star_rating(5)).to eq '★★★★★'
    end
    it 'returns three black stars and two white stars for three' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end
    it 'returns four black stars and one white star for 3.5' do
    	expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end

  context '#how_old' do
    let(:time) {DateTime.new(2015, 11, 26)}
    it 'converts the difference of time to hours' do
      expect(helper.how_old(time)).to eq ((Time.now - time) / 3600).round
    end
  end
  context '#hours_string' do
    let(:time) {12}
    it 'add the hours into a string' do
      expect(helper.hours_string(time)).to eq "#{time} hours ago"
    end
  end
end
