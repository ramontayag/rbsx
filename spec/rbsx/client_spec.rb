require "spec_helper"

module Rbsx
  describe Client do

    describe "initialization" do
      Rbsx::CONFIG_ATTRS.each do |attr|
        it "accepts #{attr}" do
          client = described_class.new(attr => "localval")
          expect(client.send(attr)).to eq "localval"
        end
      end
    end

    describe "#sx" do
      it "executes the command with the sx_path" do
        client = described_class.new(sx_path: "/path/sx")
        expect(client).to receive(:`).with("/path/sx mycommand")
        client.sx "sx mycommand"
      end

      context "given the wrong sx path" do
        it "raises an error describing what might be wrong" do
          client = described_class.new(sx_path: "/nonexistent")
          expect { client.sx("sx help") }.to raise_error(
            SxNotFound,
            [
              "sx path `/nonexistent` does not seem to exist.",
              "Please make sure that you can execute `/nonexistent help`.",
            ].join(" ")
          )
        end
      end
    end

    describe "#bci_fetch_last_height" do
      it "returns the result of `bci-fetch-last-height`" do
        client = described_class.new
        allow(client).to receive(:sx).
          with("sx bci-fetch-last-height").
          and_return("12387237")
        expect(client.bci_fetch_last_height).to eq 12387237
      end
    end

    describe "#address" do
      context "there is a private key" do
        it "generates an address based on the private key" do
          client = described_class.new(
            public_key: nil,
            private_key: CONFIG[:private_key],
          )
          expect(client.address(0)).to eq CONFIG[:address_0]
        end
      end

      context "there is no private key but there is a public key" do
        it "generates an address based on the public key" do
          client = described_class.new(
            public_key: CONFIG[:public_key],
            private_key: nil,
          )
          expect(client.address(0)).to eq CONFIG[:address_0]
        end
      end
    end

    describe "#valid_address?" do
      subject { described_class.new.valid_address?(address) }
      context "address is valid" do
        let(:address) { CONFIG[:address_0] }
        it { is_expected.to be true }
      end

      context "address is not valid" do
        let(:address) { "abc" }
        it { is_expected.to be false }
      end
    end

    describe "#new_private_key" do
      it "generates a new private key" do
        client = described_class.new
        private_key = client.new_private_key
        client.private_key = private_key
        address = client.address(0)
        expect(client.valid_address?(address)).to be true
      end
    end

  end
end
