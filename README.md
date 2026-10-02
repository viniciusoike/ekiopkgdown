# ekiopkgdown

ekiopkgdown is a pkgdown template that gives EKIO packages a shared look:
brand colors, Lora/Lato/Fira Code type, a navy navigation bar, dark mode,
and the "Developed by EKIO" badge.

## Usage

Point the site at the template in `_pkgdown.yml`:

```yaml
template:
  package: ekiopkgdown
```

Add the template to `DESCRIPTION`, so the pkgdown GitHub Action installs it:

```
Config/Needs/website: viniciusoike/ekiopkgdown
```

To build the site locally, install the template first:

```r
pak::pak("viniciusoike/ekiopkgdown")
```

## Customizing a site

Each key in the site's own `_pkgdown.yml` overrides the matching template
key and leaves the rest in place. For example, this keeps the EKIO look and
changes only the footer text:

```yaml
footer:
  components:
    ekio: "Part of EKIO's visual identity system."
```

Site-specific styles go in `pkgdown/extra.scss`. They load after the
template's styles and can use its custom properties, such as
`var(--ekio-accent)` and `var(--ekio-rule)`.

## Brand tokens

Colors come from `inst/ekio-palettes.yaml` in
[ekioplot](https://github.com/viniciusoike/ekioplot). When a token changes
there, update `inst/pkgdown/_pkgdown.yml`, `inst/pkgdown/extra.scss`, and the
token list in `tests/testthat/test-template.R`.
