Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '8Njx4qc53NxmamkWfwDKIrWBB', 'Mz9GntNwuYcEY2S9O7y2Zel2GvNuJ0HfOCNdT3sGfAergTlt8S'
  provider :facebook, '400218056827436', 'a700ba692e2ac2c75e0abb893f05bff0'
end
