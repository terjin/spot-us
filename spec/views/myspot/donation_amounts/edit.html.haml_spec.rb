require File.dirname(__FILE__) + "/../../../spec_helper"

describe 'myspot/donation_amounts/edit' do
  before do
    @user = Factory(:user)
    template.stub!(:current_user).and_return(@user)
    @pitches = [Factory(:pitch), Factory(:pitch)]
    @donations = @pitches.collect {|pitch| Factory(:donation, :user => @user,
                                                              :pitch => pitch) }
    assigns[:donations] = @donations
    assigns[:user]      = @user
  end

  it 'should render' do
    do_render
  end

  it "should have a form to update the user's donations" do
    do_render
    template.should have_tag('form[method="post"][action=?]', myspot_donations_amounts_path) do
      with_tag('input[name="_method"][value="put"]')
    end
  end

  it "should have a text field tag to change the amount of each donation" do
    do_render
    @donations.each do |donation|
      template.should have_tag('input[type="text"][name=?]', "user[donation_amounts][#{donation.id}]")
    end
  end

  it "should display error messages when available" do
    @user.stub!(:errors).and_return(["oh hai"])
    template.should_receive(:content_for).with(:error).once
    do_render
  end

  def do_render
    render 'myspot/donation_amounts/edit'
  end
end
