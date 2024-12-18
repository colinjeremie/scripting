# Jira scripts helper

## Those scripts require two env variables : JIRA_EMAIL and JIRA_TOKEN to access to the jira project

```
checkout_branch.sh
Usage: ./checkout_branch.sh jira_url -- Checkout a git branch from a jira url
```

```
commit_message.sh
Usage: ./commit_message.sh -- Print the jira ticket title associated with the current git branch
```

```
force_rebase.sh.sh
Usage: ./force_rebase.sh -- force rebase on origin/develop the current git branch and push force it
```

```
new_branch.sh
Usage: ./new_branch.sh jira_url -- Create and checkout a new git branch from a jira url
```

```
generate_branch.sh
Usage: ./generate_branch.sh jira_url -- Print a git branch name from a jira url
```
