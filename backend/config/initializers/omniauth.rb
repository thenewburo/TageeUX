Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :twitter, 'NVjEUl38SpQqYfpySihmOr42I', 'ediKJgsv6WH75vowpIRD3RvM2fvujRH8Yv2OIz5GJB1fEDFbps'
    provider :instagram, '76ec7a7077a44d03b1a5a1d8ecbe32e5', 'd0b4cef904e849309f1c10c0ba59734b'
    provider :facebook, '639544642814411', 'be24a3f98394888e7018877413e27594'
  else
    provider :twitter, '9VJPZM3aEE8T6nEfFoL50ODyT', 'yRZEIJdOR06bRzPTtcgJeM0lD6z5FH9Uu8pxuKhhlmmk9aRwRW'
    provider :instagram, '12a45f2830fe4d6e98c176215cccdbc4', '2551ffc3ec8e470caf39235768436a39'
    provider :facebook, '530835570418358', 'e57dbf3d242676bb1b4c17ef27aabda8'
  end
end
