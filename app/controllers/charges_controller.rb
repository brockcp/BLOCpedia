class ChargesController < ApplicationController

  def new
  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "BigMoney Membership - #{current_user.email}", #was current_user.name
    amount: default_amount    #Amount.default
  }
  end

  def create   # Creates a Stripe Customer object, for associating # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    charge = Stripe::Charge.create(  # Where the real magic happens
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: default_amount,    #Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    current_user.premium!
    redirect_to root_path   #user_path(current_user) # or wherever

    rescue Stripe::CardError => e # Stripe will send back CardErrors, with friendly messages # when something goes wrong.  # This `rescue block` catches and displays those errors.
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def downgrade
    current_user.standard!
    current_user.wikis.update_all(private:false)
    flash[:notice] = "You are back to a regular member."
    redirect_to root_path
  end

  private

  def default_amount
   3_00
  end

end
