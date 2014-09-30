require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe MovimientosController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Movimiento. As you add validations to Movimiento, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MovimientosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all movimientoses as @movimientoses" do
      movimiento = Movimiento.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:movimientos)).to eq([movimiento])
    end
  end

  describe "GET show" do
    it "assigns the requested movimiento as @movimiento" do
      movimiento = Movimiento.create! valid_attributes
      get :show, {:id => movimiento.to_param}, valid_session
      expect(assigns(:movimiento)).to eq(movimiento)
    end
  end

  describe "GET new" do
    it "assigns a new movimiento as @movimiento" do
      get :new, {}, valid_session
      expect(assigns(:movimiento)).to be_a_new(Movimiento)
    end
  end

  describe "GET edit" do
    it "assigns the requested movimiento as @movimiento" do
      movimiento = Movimiento.create! valid_attributes
      get :edit, {:id => movimiento.to_param}, valid_session
      expect(assigns(:movimiento)).to eq(movimiento)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Movimiento" do
        expect {
          post :create, {:movimiento => valid_attributes}, valid_session
        }.to change(Movimiento, :count).by(1)
      end

      it "assigns a newly created movimiento as @movimiento" do
        post :create, {:movimiento => valid_attributes}, valid_session
        expect(assigns(:movimiento)).to be_a(Movimiento)
        expect(assigns(:movimiento)).to be_persisted
      end

      it "redirects to the created movimiento" do
        post :create, {:movimiento => valid_attributes}, valid_session
        expect(response).to redirect_to(Movimiento.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved movimiento as @movimiento" do
        post :create, {:movimiento => invalid_attributes}, valid_session
        expect(assigns(:movimiento)).to be_a_new(Movimiento)
      end

      it "re-renders the 'new' template" do
        post :create, {:movimiento => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested movimiento" do
        movimiento = Movimiento.create! valid_attributes
        put :update, {:id => movimiento.to_param, :movimiento => new_attributes}, valid_session
        movimiento.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested movimiento as @movimiento" do
        movimiento = Movimiento.create! valid_attributes
        put :update, {:id => movimiento.to_param, :movimiento => valid_attributes}, valid_session
        expect(assigns(:movimiento)).to eq(movimiento)
      end

      it "redirects to the movimiento" do
        movimiento = Movimiento.create! valid_attributes
        put :update, {:id => movimiento.to_param, :movimiento => valid_attributes}, valid_session
        expect(response).to redirect_to(movimiento)
      end
    end

    describe "with invalid params" do
      it "assigns the movimiento as @movimiento" do
        movimiento = Movimiento.create! valid_attributes
        put :update, {:id => movimiento.to_param, :movimiento => invalid_attributes}, valid_session
        expect(assigns(:movimiento)).to eq(movimiento)
      end

      it "re-renders the 'edit' template" do
        movimiento = Movimiento.create! valid_attributes
        put :update, {:id => movimiento.to_param, :movimiento => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested movimiento" do
      movimiento = Movimiento.create! valid_attributes
      expect {
        delete :destroy, {:id => movimiento.to_param}, valid_session
      }.to change(Movimiento, :count).by(-1)
    end

    it "redirects to the movimientos list" do
      movimiento = Movimiento.create! valid_attributes
      delete :destroy, {:id => movimiento.to_param}, valid_session
      expect(response).to redirect_to(movimientos_url)
    end
  end

end
