require "application_system_test_case"

class ThemeToggleTest < ApplicationSystemTestCase
  test "toggle switches between light and dark and remembers the choice" do
    visit login_path
    assert_selector "html[data-theme='light']", visible: :all
    assert_selector ".theme-toggle[aria-pressed='false']"

    find(".theme-toggle").click
    assert_selector "html[data-theme='dark']", visible: :all
    assert_selector ".theme-toggle[aria-pressed='true']"

    visit login_path
    assert_selector "html[data-theme='dark']", visible: :all

    find(".theme-toggle").click
    assert_selector "html[data-theme='light']", visible: :all
  end
end
