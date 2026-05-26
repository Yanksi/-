# Personal website &mdash; Shuhao Li

Source for my academic personal website, built on the [Academic Pages](https://github.com/academicpages/academicpages.github.io) Jekyll template.

This repo only checks in the files I have actually customized:

- `_config.yml` &mdash; site / author / sidebar settings
- `_data/navigation.yml` &mdash; top nav (Publications, CV)
- `_pages/about.md` &mdash; landing page (`/`)
- `_pages/cv.md` &mdash; CV page (`/cv/`)
- `_pages/publications.html` &mdash; publications page with a placeholder until papers land
- `bootstrap.sh` &mdash; one-shot script that pulls the rest of the academicpages template on top

## Getting it running

The template files (layouts, includes, sass, JS, fonts, favicons, etc.) are
NOT in this repo; they live upstream in academicpages. To populate them, clone
this repo locally and run:

```bash
./bootstrap.sh
```

The script clones the upstream template, copies everything I have not
customized into the working tree, and leaves the result staged for `git status
&& git add -A && git commit && git push`.

After bootstrapping, drop in:

- `images/profile.png` &mdash; your sidebar avatar (replace the default)
- `files/cv.pdf` &mdash; the PDF of your CV linked from the CV page

## Hosting

This repo is currently `yanksi/-`, so GitHub Pages will serve it under:

> `https://yanksi.github.io/-/`

The `baseurl: "/-"` in `_config.yml` reflects that. To host at the cleaner
`https://yanksi.github.io`, rename the GitHub repo to `yanksi.github.io` and
change `baseurl` to `""` in `_config.yml`.

Enable hosting at: repo Settings &rarr; **Pages** &rarr; *Deploy from a branch*.

## Local preview

After bootstrapping, with Ruby + Bundler installed:

```bash
bundle install
bundle exec jekyll serve -l -H 0.0.0.0
```

Then open `http://localhost:4000/-/`.

## Adding content

Add a publication by dropping a Markdown file into `_publications/` following
the [Academic Pages format](https://academicpages.github.io/markdown/); the
publications page will pick it up automatically and drop the
"papers in preparation" placeholder.
