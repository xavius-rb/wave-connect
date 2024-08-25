RSpec.shared_examples :controller do |klass, except: [], namespace: nil|
  except = Array.wrap(except)

  # Helper to handle polymorphic paths with namespace
  define_method(:polymorphic_with_namespace) do |resource|
    if namespace
      polymorphic_path([*namespace.call, resource])
    else
      polymorphic_path(resource)
    end
  end

  unless except.include?(:index)
    describe "GET /index" do
      it "renders a successful response" do
        get polymorphic_with_namespace(klass)
        expect(response).to be_successful
      end
    end
  end

  unless except.include?(:show)
    describe "GET /show" do
      it "renders a successful response" do
        object = klass.create!(valid_attributes)
        get polymorphic_with_namespace(object)
        expect(response).to be_successful
      end
    end
  end

  unless except.include?(:new)
    describe "GET /new" do
      it "renders a successful response" do
        #get new_polymorphic_path([*namespace.call, klass].compact)
        path = namespace ? new_polymorphic_path([*namespace.call, object].compact) : new_polymorphic_path(klass)
        get path
        expect(response).to be_successful
      end
    end
  end

  unless except.include?(:edit)
    describe "GET /edit" do
      it "renders a successful response" do
        object = klass.create!(valid_attributes)
        #get edit_polymorphic_path([*namespace.call, object].compact)
        path = namespace ? edit_polymorphic_path([*namespace.call, object].compact) : edit_polymorphic_path(object)
        get path
        expect(response).to be_successful
      end
    end
  end

  unless except.include?(:create)
    describe "POST /create" do
      let(:make_request) do
        post polymorphic_with_namespace(klass), params: request_params
      end

      context "with valid parameters" do
        let(:request_params) do
          { klass.name.underscore => valid_attributes }
        end

        it "creates a new #{klass.name}" do
          expect { make_request }.to change(klass, :count).by(1)
          expect(flash[:notice]).to match(/#{klass.model_name.human} was successfully created.*/)
        end
      end

      context "with invalid parameters" do
        let(:request_params) do
          { klass.name.underscore => invalid_attributes }
        end

        it "does not create a new #{klass.name}" do
          expect { make_request }.not_to change(klass, :count)
        end

        it "renders a unprocessable_entity response" do
          make_request
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  unless except.include?(:update)
    describe "PATCH /update" do
      let(:make_request) do
        patch polymorphic_with_namespace(object), params: request_params
      end

      let(:object) { klass.create!(valid_attributes) }

      context "with valid parameters" do
        let(:request_params) do
          { klass.name.underscore => valid_attributes }
        end

        it "updates the requested #{klass.name}" do
          make_request
          expect(flash[:notice]).to match(/#{klass.model_name.human} was successfully updated.*/)
        end
      end

      context "with invalid parameters" do
        let(:request_params) do
          { klass.name.underscore => invalid_attributes }
        end

        it "renders a unprocessable_entity response" do
          make_request
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  unless except.include?(:destroy)
    describe "DELETE /destroy" do
      let!(:object) { klass.create!(valid_attributes) }

      it "destroys the requested #{klass.name}" do
        expect { delete polymorphic_with_namespace(object) }.to change(klass, :count).by(-1)
      end

      it "redirects to the #{klass.name.pluralize.underscore} list" do
        delete polymorphic_with_namespace(object)
        expect(response).to redirect_to(polymorphic_with_namespace(klass))
      end
    end
  end
end
