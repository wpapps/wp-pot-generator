> **⚠️ Note:** To use this GitHub Action, you must have access to GitHub Actions. GitHub Actions are currently only available in public beta. You can [apply for Github Actions beta access here](https://github.com/features/actions).


# WordPress Pot Generator - ***Github Action***
This Action Generates POT Files for your wordpress Plugin / Theme based on the content inside Github Repo

## Configuration
* `SAVE_PATH` - Location / Path to save POT File **Required**
* `ITEM_SLUG` - Slug of your WordPress Theme / Plugin Slug  **Required**
* `DOMAIN` - WordPress Theme / Plugin ***TextDomain***
* `PACKAGE_NAME` - WordPress Theme / Plugin Name
* `GITHUB_TOKEN` - you do not need to generate one but you do have to explicitly make it available to the Action
* `HEADERS`  - Array in JSON format of custom headers which will be added to the POT file. Defaults to empty array.

## Example Workflow File
```
workflow "Deploy" {
  resolves = ["WordPress Pot Generator"]
  on = "push"
}

action "WordPress Pot Generator" {
  uses = "varunsridharan/wordpress-pot-generator@master"
  env = {
    SAVE_PATH = "langs/filename.pot"
    ITEM_SLUG = "your-textdomain"
  }
  secrets = ["GITHUB_TOKEN"]
}
```

---
## Contribute
If you would like to help, please take a look at the list of
[issues][issues] or the [To Do](#-todo) checklist.

## License
Our GitHub Actions are available for use and remix under the MIT license.

## Copyright
2017 - 2018 Varun Sridharan, [varunsridharan.in][website]

If you find it useful, let me know :wink:

You can contact me on [Twitter][twitter] or through my [email][email].

## Backed By
| [![DigitalOcean][do-image]][do-ref] | [![JetBrains][jb-image]][jb-ref] |  [![Tidio Chat][tidio-image]][tidio-ref] |
| --- | --- | --- |

[do-image]: https://vsp.ams3.cdn.digitaloceanspaces.com/cdn/DO_Logo_Horizontal_Blue-small.png
[jb-image]: https://vsp.ams3.cdn.digitaloceanspaces.com/cdn/phpstorm-small.png?v3
[tidio-image]: https://vsp.ams3.cdn.digitaloceanspaces.com/cdn/tidiochat-small.png
[do-ref]: https://s.svarun.in/Ef
[jb-ref]: https://www.jetbrains.com
[tidio-ref]: https://tidiochat.com

