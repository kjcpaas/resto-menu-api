# Worklog

## Preparations

*I can only do the technical assessment during the weekend due to other commitments so these are what I did to prepare:*

- Read the specifications
- Install latest Ruby version (3.3.1)
    - brew upgrade ruby-build
    - rbenv install 3.3.1
- Create task list (see Todo)
- Identify gaps in knowledge

## Todo

### **Gap** Read up on implementing GraphQL in RoR

It’s been 6 years since I used GraphQL with RoR and I have never set it up from scratch

Main reference: https://www.apollographql.com/blog/using-graphql-with-ruby-on-rails

### Setup Github repo

Setup at: https://github.com/kjcpaas/resto-menu-api

### Generate API-only RoR project

Using:

```
rails new resto-menu --api
```

This created the project with only the necessary modules for API development (e.g. no View, etc.) to make the code lightweight and easy to navigate.

Generated directories that won't be used were remove too (e.g. mailer, jobs, cable).

I also removed `test/` as I plan to use Rspec instead.

### Integrate rubocop

Before writing the first code, I will integrate rubocop to fix the styles.

I only used the default cops with minor adjustments.

###  Write schema migrations

Migrations with created along with the model using `rails generate` commands like:

```
rails generate model Menu identifier:string label:string state:string start_date:date end_date:date
```

Generated migration and model files were edited to ensure primary keys, references, indexes, etc are properly defined.

#### Order of model generation

Based on the provided ERD, the models were generated in the following order to ensure that models are generated before they are reference by another model:

- Menu
- Section
- MenuSection
- Item
- Section Item
- Modifier Group
- Modifier
- Item Modifier Group

**NOTE**: Based on email with Sunny, I implemented Modifier such that it only references `ModifierGroup` because of contradictions of the circular reference.

This allows Modifier Group to be reused by other items as well (e.g. Drink Sizes can be used by any drink in the menu)

#### Primary keys

I set `id: false` in model migrations to follow the specifications according to the provided ERD.

This means, using a string `identifier` as primary key for most models, instead of integer `id` that Rails provides.

For other models that reference other models, I defined composite primary keys.

#### Validations

Aside from the values provided in the ERD, I also added validations based on assumptions and use cases I imagined.

Comments were added in model code where assumptions were made.

Ensuring data integrity is a combination of model validations and DB validations.

Defaults and presence requirements can be checked by DB but we will also implement the same validations and more in the model layer.

- Generate seed data
- Deploy api (will use Heroku for simplicity)
- Setup CI/CD pipeline
    - rubocop (use Airbnb styles)
- Design GraphQL mutations for reading data
    - 1st mutation will be simple, and will write test after (to get the hang of RoR + GraphQL)
    - TDD will be used for the next mutations (Tests serve as design specification)
