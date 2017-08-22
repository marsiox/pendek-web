require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

RSpec.describe "Pendek Controller", type: :controller do

  let(:urls_get_response) {
    {
      "data": [{
        "id": "vGwd2u",
        "type": "url",
        "attributes": {
          "full_url": "http://www.site.com/longtest",
          "short_url": "http://pndk.id:3000/vGwd2u"
        }
      }]
    }
  }

  let(:error_response) {
    {
      "errors": [{
        "id": "Error",
        "title": "Message"
      }]
    }
  }

  let(:urls_post_response) {
    {
      "data": {
        "id": "7lEz9Y",
        "type": "url",
        "attributes": {
          "full_url": "http://www.site.com/longtest",
          "short_url": "http://pndk.id:3000/7lEz9Y"
        }
      }
    }
  }

  describe "GET /" do
    context "with valid response" do
      it "returns status ok" do
        stub_request(:get, "http://localhost:3000/api/urls").
          with(headers: { 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby' }).
          to_return(status: 200, body: urls_get_response.to_json)

        get "/"

        expect(last_response).to be_ok
      end
    end

    context "with error response" do
      it "displays error message" do
        stub_request(:get, "http://localhost:3000/api/urls").
          with(headers: { 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby' }).
          to_return(status: 422, body: error_response.to_json)

        get "/"

        expect(last_response).to be_ok
        expect(last_response.body).to match(/Error/)
      end
    end
  end

  describe "POST /" do
    it "registeres an url" do
      stub_request(:post, "http://localhost:3000/api/urls").
          with(body: { data: { full: "http://www.site.com/longtest" } },
               headers: { 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby' }).
          to_return(status: 200, body: urls_post_response.to_json)

      post "/", { url: "http://www.site.com/longtest" }

      expect(last_response).to be_redirect
    end
  end

end
