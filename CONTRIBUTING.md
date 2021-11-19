# Contributing

First of all, thanks for contributing to the Rocky Linux QA/Testing team!

We're happy you've decided to help up make Rocky Linux better, and we hope you'd
like to keep doing so in the future.

However, with the intent of keeping everything manageable and reducing stress on
every project member & collaborator, we need to set some policies on
contributions.

## Linting & Commit Hooks

We use [pre-commit](https://pre-commit.com) for our linting & quality control
tooling, so it is required that you install the pre-commit hook so that your PR
meets our quality control standards. If you fail to do this, we have
[pre-commit.ci](https://pre-commit.ci) configured on all PRs, and it will flag
up any errors that there may be.

```shell
# After installing pre-commit...
$ pre-commit install
```

## Pull requests

Allow us to preface this by saying - All test reports, test cases, tools,
issues, etc. are all _very_ much welcome. We don't wish to discourage any such
contributions, quite the opposite.

With that said, we must ask that:

- Pull requests for bug fixes and new features must be linked to an issue and
  must be made against the `develop` branch. If there is no issue currently open
  describing the issue/feature request you are contributing a solution to, open
  one yourself first, _before_ you make a PR. This is to ensure that we know
  every part of our project is organized well, and makes sure that we are able
  to track every problem and enhancement the community would like to raise with
  us.

- Once an issue has been created, you wait until we have evaluated the impact of
  the issue, or the priority of the feature request, before creating your PR. By
  all means, make your changes preemptively in your own fork, but don't create a
  PR for any issues before a PR has been requested by maintainers.

- Pull requests for test reports which are the output of running `./xsos` as
  described in the [Test Report README.md](./test-reports/README.md) *do not*
  require an issue to be created in advance of submission. However, please be
  sure to use the Test Report Pull Request Template to help ensure your PR meets
  our submission guidelines for Test Reports.

## License

You must understand & acknowledge that any changes you submit into our project's
version control history are licensed under the BSD 3-clause license, the terms
of which are described fully in the [LICENSE](./LICENSE) file, located at the
root of this repository.
