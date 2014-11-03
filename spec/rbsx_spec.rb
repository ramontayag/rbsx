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
    described_class::CONFIG_ATTRS.each do |attr|
      it "returns an instance of Client" do
        Rbsx.send :"#{attr}=", "globalval"
        client = double(Rbsx::Client)
        allow(Rbsx::Client).to receive(:new).with(attr => "globalval").
          and_return(client)
        expect(described_class.new).to eq client
      end

      context "#{attr} is given" do
        it "overrides the default" do
          Rbsx.sx_path = "globalval"
          client = double(Rbsx::Client)
          allow(Rbsx::Client).to receive(:new).with(attr => "localval").
            and_return(client)
          expect(described_class.new(attr => "localval")).to eq client
        end
      end
    end
  end

end
