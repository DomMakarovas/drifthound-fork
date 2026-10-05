require "application_system_test_case"

class ThemeToggleTest < ApplicationSystemTestCase
  def setup
    emulate_color_scheme("light")
    visit login_path
    page.execute_script("localStorage.removeItem('drifthound-theme')")
  end

  def teardown
    page.driver.browser.execute_cdp("Emulation.setEmulatedMedia", features: [])
  end

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

  test "follows the OS colour scheme until the user picks a theme" do
    emulate_color_scheme("dark")
    visit login_path
    assert_selector "html[data-theme='dark']", visible: :all

    find(".theme-toggle").click
    assert_selector "html[data-theme='light']", visible: :all

    visit login_path
    assert_selector "html[data-theme='light']", visible: :all
  end

  private

  def emulate_color_scheme(scheme)
    page.driver.browser.execute_cdp(
      "Emulation.setEmulatedMedia",
      features: [ { name: "prefers-color-scheme", value: scheme } ]
    )
  end
end
