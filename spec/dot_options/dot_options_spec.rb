describe DotOptions do
  subject { described_class.new options }

  let(:options) do
    {
      debug:  true,
      output: { color: true },
      skin:   { background: { color: :black, texture: 'Stripes' } },
    }
  end

  describe '#inspect' do
    it 'returns a developer-friently string' do
      expect(subject.inspect).to match_approval('inspect')
    end
  end

  describe '#to_s' do
    it 'returns a user-friently string' do
      expect(subject.to_s).to match_approval('to_s')
    end
  end

  describe '#respond_to?' do
    it 'returns true for available options' do
      expect(subject.skin.background).to respond_to :color
    end

    it 'returns false for invalid options' do
      expect(subject.skin.background).not_to respond_to :opacity
    end
  end

  describe '#method_missing' do
    it 'enables read access to deeply nested options' do
      expect(subject.skin.background.color).to eq :black
    end

    it 'enables write access to deeply nested options' do
      subject.skin.background.color = :blue
      expect(subject.skin.background.color).to eq :blue
    end

    context 'when assigning a hash' do
      it 'converts it to a DotOptions' do
        subject.skin.foreground = { color: :white, font: 'JetBrains Mono' }
        expect(subject.skin.foreground.color).to eq :white
      end
    end

    context 'with an invalid option' do
      it 'raises OptionNotFoundError with a clear message' do
        expect { subject.skin.background.border }.to raise_approval('option-not-found1')
      end
    end
  end
end
