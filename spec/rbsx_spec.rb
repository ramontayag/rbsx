require "spec_helper"

describe Rbsx do

  describe ".configure" do
    it "yields Rbsx to set the configuration" do
      Rbsx.configure do |c|
        c.sx_path = "/path/to/sx"
      end

      expect(Rbsx.sx_path).to eq "/path/to/sx"
    end
  end

  describe ".sx_path" do
    it "is a setter/getter" do
      Rbsx.sx_path = "a"
      expect(Rbsx.sx_path).to eq "a"
    end
  end

  describe ".new" do
    it "returns an instance of Client" do
      Rbsx.sx_path = "/sx/path"
      client = double(Rbsx::Client)
      allow(Rbsx::Client).to receive(:new).with(sx_path: "/sx/path").
        and_return(client)
      expect(described_class.new).to eq client
    end

    context "sx_path is given" do
      it "overrides the default" do
        Rbsx.sx_path = "/old/sx"
        client = double(Rbsx::Client)
        allow(Rbsx::Client).to receive(:new).with(sx_path: "/sx/path").
          and_return(client)
        expect(described_class.new(sx_path: "/sx/path")).to eq client
      end
    end
  end

end
