require_relative '../lib/member'

describe Member do
  describe 'initialization' do
    let(:valid_attrs) do
      {
        name: 'Carlos Ruiz',
        role: 'Backend Developer',
        skills: ['Ruby', 'SQL'],
        bio: 'Especialista en bases de datos'
      }
    end

    it 'creates successfully with valid attributes' do
      expect { Member.new(valid_attrs) }.not_to raise_error
    end

    it 'raises error with missing required fields' do
      expect { Member.new({}) }.to raise_error(/Missing required fields/)
    end
  end
end
