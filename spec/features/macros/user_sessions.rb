module AcceptanceMacros
  def authenticate
    visit root_path
    click_link 'Logar com o Twitter'
  end
end
