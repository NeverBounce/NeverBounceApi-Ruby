
describe NeverBounce::API::Response::AccountInfo do
  include_dir_context __dir__

  it_behaves_like "instantiatable"
  it_behaves_like "properly inherited"

  # OPTIMIZE: Feed real data here some day.
end
