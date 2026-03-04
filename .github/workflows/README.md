# Workflow Info

## `required_lint_check.yaml`

The workflows for linting using `pylint`.

### Setup

First we need to get the same linter config that GitHub Actions are using. It's
stored alongside our other global workflows and defaults in
our `.github` repo. Let's clone that and move to a local, central location in `~/.gen3`:

```bash
git clone git@github.com:uc-cdis/.github.git ~/.gen3/.github
```

> Note: Some Gen3 services may do this setup for you.

### Modifying the Linter configs

### Edit the `~/.gen3/.github/.github/.python-lint`

There's a utility to modify this appropriately so it understands the top
level packages for the service/library you're working on. Make sure you're in your virtual env or the root of the repo you're trying to lint first and then use the utility.

> Ensure you've run `poetry install` before this so your virtual env exists

```bash
cd repos/gen3-discovery-ai  # a repo you are working on and want to lint
bash ~/.gen3/.github/.github/linters/update_pylint_config.sh
```

### What was all that setup?

Some linters require knowing the module name and
location of imported packages (e.g. dependencies). This is done for pylint by using that
utility. It updates pylint config with your virtual env path to the installed packages.
