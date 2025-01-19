# Branching Strategy

## Overview
We follow the GitFlow branching model with the following branches:

- `main`: Production-ready code
- `develop`: Main development branch
- `feature/*`: New features
- `release/*`: Release preparation
- `hotfix/*`: Production hotfixes

## Branch Policies

### Main Branch
- No direct commits
- Requires pull request with minimum 1 reviewer
- Must be linked to a work item
- Must pass all build validations
- Must pass SonarQube quality gate

### Develop Branch
- No direct commits
- Requires pull request
- Must be linked to a work item
- Must pass build validation

### Feature Branches
- Created from: develop
- Merge to: develop
- Naming: feature/[work-item-id]-description

## Work Items Integration
All commits must be linked to a work item using the following format in commit messages:
`AB#[work-item-id] commit message`

## Pull Request Template
```markdown
## Description
[Describe the changes made in this PR]

## Related Work Item
AB#[work-item-id]

## Type of change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Configuration change

## Checklist
- [ ] Unit tests added/updated
- [ ] Documentation updated
- [ ] SonarQube issues addressed
- [ ] Docker image builds successfully
```
