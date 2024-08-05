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
    it 'returns a developer-friendly string' do
      expect(subject.inspect).to match_approval('inspect')
    end
  end

  describe '#to_s' do
    it 'returns a user-friendly string' do
      expect(subject.to_s).to match_approval('to_s')
    end
  end

  describe '#to_h' do
    it 'returns a hash of all options' do
      expect(subject.to_h).to eq options
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

  describe '#[]' do
    it 'returns the value if the key exists' do
      expect(subject.skin[:background][:color]).to eq :black
    end

    it 'returns nil if the key does not exist' do
      expect(subject.skin[:stroke]).to be_nil
    end

    context 'with string-keys initialization dictionary' do
      let(:options) { { 'skin' => { 'color' => :red } } }

      it 'returns the value as if the keys were symbols' do
        expect(subject.skin[:color]).to eq :red
      end
    end
  end  

  describe 'dynamic attributes' do
    it 'enables read access to deeply nested options' do
      expect(subject.skin.background.color).to eq :black
    end

    it 'enables write access to deeply nested options' do
      subject.skin.background.color = :blue
      expect(subject.skin.background.color).to eq :blue
    end

    context 'when the object was initialized with string keys' do
      let(:options) { { 'skin' => { 'background' => { 'color' => :green } } } }

      it 'enables read access as if the keys were symbols' do
        expect(subject.skin.background.color).to eq :green
      end

      it 'enables write access as if the keys were symbols' do
        subject.skin.background.color = :blue
        expect(subject.skin.background.color).to eq :blue
      end
    end
  end
end
