template_path <- function(...) {
  system.file("pkgdown", ..., package = "ekiopkgdown", mustWork = TRUE)
}

read_template_config <- function() {
  yaml::read_yaml(template_path("_pkgdown.yml"))
}

test_that("template config targets Bootstrap 5 with a light switch", {
  config <- read_template_config()

  expect_equal(config$template$bootstrap, 5)
  expect_true(config$template$`light-switch`)
})

test_that("template config sets the EKIO surfaces and type", {
  bslib <- read_template_config()$template$bslib

  expect_equal(bslib$bg, "#FBFBF6")
  expect_equal(bslib$fg, "#191A1C")
  expect_equal(bslib$primary, "#1E3A5F")
  expect_equal(bslib$`navbar-bg`, "#152A44")
  expect_equal(bslib$base_font$google, "Lato")
  expect_equal(bslib$heading_font$google, "Lora")
  expect_equal(bslib$code_font$google, "Fira Code")
})

test_that("navbar template links the EKIO badge shipped in assets", {
  navbar <- readLines(template_path("templates", "navbar.html"))
  badge <- "ekio-badge-developed-by.svg"

  expect_true(any(grepl(badge, navbar, fixed = TRUE)))
  expect_true(file.exists(template_path("assets", badge)))
})

test_that("extra.scss is shipped", {
  expect_true(file.exists(template_path("extra.scss")))
})

test_that("template config uses only hex colors from the ekioplot tokens", {
  # Mirrors inst/ekio-palettes.yaml in ekioplot. Update both together.
  tokens <- c(
    "#FBFBF6", "#191A1C", "#1E3A5F", "#373A3D", "#CED0D4", "#F2F3F5",
    "#00605E", "#152A44", "#0D1B2A"
  )
  bslib <- unlist(read_template_config()$template$bslib)
  hex <- bslib[grepl("^#", bslib)]

  expect_true(all(hex %in% tokens), label = paste(setdiff(hex, tokens)))
})
