### coffee-shop-dbt

This is a sample project used for Analytics Engineers Club

## Running this project locally
1. Clone this github repo
2. Install dbt following [these instructions](https://docs.getdbt.com/dbt-cli/installation)
3. Auth your gcloud account with `gcloud auth login`
4. Copy the example profile to your `~/.dbt` folder (created when installing dbt):
```bash
$ cp ./sample.profiles.yml ~/.dbt/profiles.yml
```
5. Populate `~/.dbt/profiles.yml` with the credentials you obtained in step 3:
```bash
$ code ~/.dbt/profiles.yml
```
6. Verify that you can connect to your database
```bash
$ dbt debug
```
7. Verify that you can run dbt
```bash
$ dbt run
```
8. Verify that all the test pass
```bash
$ dbt test
```
9. Generate the docs for the project
```bash
$ dbt docs generate
```
10. Serve the docs for the project
```bash
$ dbt docs serve
```
