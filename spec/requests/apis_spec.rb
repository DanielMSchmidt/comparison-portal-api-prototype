require 'spec_helper'

describe "Api" do
  describe "correct cases" do
      it "should deliver an article when given ISBN" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        get root_path, headers: {"isbn": "978-3453146976"}
        puts response.body
        response.status.should be(200)
      end
      it "should deliver an article when given text"
      it "should check the authentication"
      it "should be able to add a user"
      it "should be able to change attributes of a user"
      it "should be able to delete a user"
      it "should be able to get all carts of user"
      it "should be able to create a new user"
      it "should be able to add an item to a cart"
      it "should be able to remove an item from a cart"
      it "should be able to delte a cart"
  end
end
