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

## Contributing
Want to help? Check out our [contributing guidelines](CONTRIBUTING.md) to get started.

## License
Our GitHub Actions are available for use and remix under the MIT license.
