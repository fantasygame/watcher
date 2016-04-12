describe User do
  let(:user) { create(:user) }

  it { is_expected.to respond_to(:name) }

  it "#name returns a string" do
    expect(user.name).to match "Test User"
  end
end
