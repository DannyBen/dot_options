class Skin < DotOptions
  DEFAULTS = {
    color: :black,
    border: { color: :red, width: 3 },
  }

  def initialize(options = nil, *)
    opts = DEFAULTS.merge(options || {})
    super(opts, *)
  end
end

describe 'DotOptions subclassing' do
  subject { Skin.new options }

  let(:options) { nil }

  it 'allows reading properties' do
    expect(subject.border.color).to eq :red
  end

  it 'allows updating properties' do
    subject.border.color = :green
    expect(subject.border.color).to eq :green
  end

  context 'when initializing with updated properties' do
    let(:options) { { color: :yellow, code: { font: 'JetBrains Mono' } } }

    it 'overrides the default properties' do
      expect(subject.color).to eq :yellow
    end

    it 'adds any additional properties' do
      expect(subject.code.font).to eq 'JetBrains Mono'
    end
  end
end
