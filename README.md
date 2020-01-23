# aws2

This plugin provides completion support for version 2 of the [awscli](https://docs.aws.amazon.com/cli/index.htmll)
and a few utilities to manage AWS profiles and display them in the prompt.

To use it, add `aws2` to the plugins array in your zshrc file.

```zsh
plugins=(... aws2)
```

## Installation

First, you'll need to install version 2 of the CLI tool onto your system. Please checkout the 
[documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) for more information. Once you have 
the cli tools installed you can pop the **aws2** directory into your ohmyzsh plugin directory and the 
**aws2_zsh_complerer.sh** into one of the binary directory that's specified within your ${PATH} environment variable.

## Plugin commands

* `asp2 [<profile>]`: sets `$AWS_PROFILE` and `$AWS_DEFAULT_PROFILE` (legacy) to `<profile>`.
  It also sets `$AWS_EB_PROFILE` to `<profile>` for the Elastic Beanstalk CLI.
  Run `asp2` without arguments to clear the profile.

* `agp2`: gets the current value of `$AWS_PROFILE`.

* `aws2_change_access_key`: changes the AWS access key of a profile.

* `aws2_profiles`: lists the available profiles in the  `$AWS_CONFIG_FILE` (default: `~/.aws/config`).
  Used to provide completion for the `asp2` function.

## Plugin options

* Set `SHOW_AWS2_PROMPT=false` in your zshrc file if you want to prevent the plugin from modifying your RPROMPT.
  Some themes might overwrite the value of RPROMPT instead of appending to it, so they'll need to be fixed to
  see the AWS profile prompt.

## Theme

The plugin creates an `aws2_prompt_info` function that you can use in your theme, which displays
the current `$AWS_PROFILE`. It uses two variables to control how that is shown:

- ZSH_THEME_AWS_PREFIX: sets the prefix of the AWS_PROFILE. Defaults to `<aws:`.

- ZSH_THEME_AWS_SUFFIX: sets the suffix of the AWS_PROFILE. Defaults to `>`.

## Brew support

I'm a Linux user and don't have a clue how homebrew works or if any of this stuff is available for brew? For this reason
I've had to remove the homebrew parts form now.

## Thanks

Shout out to the original authon [Marc Cornellà](https://twitter.com/MarcCornella) for providing such an awesome plugin.