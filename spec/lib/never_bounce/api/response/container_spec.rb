
module NeverBounce; module API; module Response
  describe Container do
    include_dir_context __dir__

    it_behaves_like "instantiatable"
    it_behaves_like "properly inherited"

    describe "#body_hash" do
      it "requires `raw`" do
        expect { newo.body_hash }.to raise_error(AttributeError, "Attribute must be set: raw")
      end

      it "generally works" do
        r = newo(raw: '{"a":10}')
        expect(r.body_hash).to eq({"a" => 10})
      end
    end

    describe ".oattr" do
      # NOTE: Tests for this section are a few "matrix" scenarios which reasonably cover possible combinations.
      context "case 1" do
        let(:klass) do
          Class.new(described_class) do
            oattr :a, :scalar
            oattr :b, :scalar, type: :integer
            oattr :c, :scalar, type: :integer, allow_nil: true
            oattr :d, :writer
            oattr :e, :custom
            oattr :f, :scalar, type: :float
            oattr :g, :scalar, type: :float, allow_nil: true

            def d
              @d ||= body_hash.fetch("d")
            end

            def e
              @e ||= body_hash.fetch("e")
            end

            def e=(v)
              @e = v
            end
          end
        end

        it "generally works" do
          expect(klass.oattrs).to eq [:a, :b, :c, :d, :e, :f, :g]

          r = klass.new(body_hash: {})
          expect { r.a }.to raise_error KeyError
          expect { r.d }.to raise_error KeyError
          expect { r.e }.to raise_error KeyError
          expect { r.f }.to raise_error KeyError

          # Numeric conversion, valid values.
          r = klass.new(body_hash: {
            "b" => "12",
            "c" => "34",
            "f" => "1.2",
            "g" => "3.4",
          })
          expect(r.b).to eq 12
          expect(r.c).to eq 34
          expect(r.f).to eq 1.2
          expect(r.g).to eq 3.4

          # Numeric conversion, empty strings.
          r = klass.new(body_hash: {
            "b" => "",
            "c" => "",
            "f" => "",
            "g" => "",
          })
          expect { r.b }.to raise_error(ArgumentError, /^invalid value for Integer/)
          expect { r.c }.to raise_error(ArgumentError, /^invalid value for Integer/)
          expect { r.f }.to raise_error(ArgumentError, /^invalid value for Float/)
          expect { r.g }.to raise_error(ArgumentError, /^invalid value for Float/)

          # Numeric conversion, invalid strings.
          r = klass.new(body_hash: {
            "b" => "xyz",
            "c" => "xyz",
            "f" => "xyz",
            "g" => "xyz",
          })
          expect { r.b }.to raise_error(ArgumentError, /^invalid value for Integer/)
          expect { r.c }.to raise_error(ArgumentError, /^invalid value for Integer/)
          expect { r.f }.to raise_error(ArgumentError, /^invalid value for Float/)
          expect { r.g }.to raise_error(ArgumentError, /^invalid value for Float/)

          # Nill allowance.
          r = klass.new(body_hash: {
            "b" => nil,
            "c" => nil,
            "f" => nil,
            "g" => nil,
          })
          expect { r.b }.to raise_error(TypeError, /nil into Integer/)
          expect(r.c).to be nil
          expect { r.f }.to raise_error(TypeError, /nil into Float/)
          expect(r.g).to be nil

          # Complete set.
          r = klass.new(body_hash: {
            "a" => "hello",
            "b" => 10,
            "c" => 20,
            "d" => [1, 2, 3],
            "e" => {kk: 1},
            "f" => 1.5,
            "g" => 2.6,
          })

          expect { r.touch }.not_to raise_error   # An important one.

          expect(r.a).to eq "hello"
          expect(r.b).to eq 10
          expect(r.c).to eq 20
          expect(r.d).to eq([1, 2, 3])
          expect(r.e).to eq({kk: 1})
          expect(r.f).to eq 1.5
          expect(r.g).to eq 2.6

          # Accessors.
          r.a += "!"
          expect(r.a).to eq "hello!"
          r.b += 1
          expect(r.b).to eq 11
          r.c += 1
          expect(r.c).to eq 21
          r.d += [4]
          expect(r.d).to eq [1, 2, 3, 4]
          r.f += 0.1
          expect(r.f).to eq 1.6
          r.g += 0.1
          expect(r.g).to eq 2.7
        end
      end
    end
  end
end; end; end
