# Worklog

## Preparations

*I can only do the technical assessment during the weekend due to other commitments so these are what I did to prepare:*

- Read the specifications
- Install latest Ruby version (3.3.1)

```
brew upgrade ruby-build
rbenv install 3.3.1
```

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

This allows Modifier Group to be reused by other items as well (e.g. Drink Sizes can be used by any drink in the menu)

#### Primary keys

I set `id: false` in model migrations to follow the specifications according to the provided ERD.

This means, using a string `identifier` as primary key for most models, instead of integer `id` that Rails provides.

For other models that reference other models, I defined composite primary keys.

Due to these non-standard requirements, extra care must be done to ensure that foreign key references work with RoR's auto-references.

#### Validations

Aside from the values provided in the ERD, I also added validations based on assumptions and use cases I imagined.

Comments were added in model code where assumptions were made.

Ensuring data integrity is a combination of model validations and DB validations.

Defaults and presence requirements can be checked by DB but we will also implement the same validations and more in the model layer.

## Generate seed data

With the help of ChatGPT, I generated data for a Seasonal Menu of a fictional Japanese restaurant.

```
-------------------------------------------
          Sakura Blossom Delights
-------------------------------------------
Embark on a culinary journey through the delicate flavors of the season with our Sakura Blossom Delights menu, featuring Chef Hiroshi's exquisite creations.

-------------------------------------------
            Chef's Table
-------------------------------------------
Sakura Omakase:
- Indulge in an exclusive dining experience at our Chef's Table, curated by Chef Hiroshi, where you entrust the chef to craft a bespoke tasting menu highlighting the essence of cherry blossoms with each dish. ($150 per person)

-------------------------------------------
                Drinks
-------------------------------------------
Elevate your dining experience with carefully curated beverages:

Sakura Blossom Tea (Sakura-cha):
- Oyu (Hot): Indulge in the comforting warmth of fragrant green tea infused with delicate cherry blossoms, offering a soothing accompaniment to your meal. ($8)
- Hiya (Cold): Refresh your palate with the crisp and invigorating flavors of chilled green tea infused with delicate cherry blossoms, perfect for enjoying on a warm day. ($8)

Sakura Sake (Sakura Nihonshu):
- Tokkuri (Small Flask): A single-serving flask of premium sake infused with the essence of cherry blossoms, perfect for savoring the flavors of the season. ($12)
- Chokkari (Medium Flask): A medium-sized flask of premium sake, ideal for sharing and enhancing the culinary journey with friends or loved ones. ($18)
- Otokka (Large Flask): A generous flask of premium sake, symbolizing celebration and joy, to elevate your dining experience to new heights. ($25)

Please indicate your preferred options for the Sakura-cha and Sakura Nihonshu upon reservation.
-------------------------------------------

Enjoy your Sakura Blossom Delights experience!
```

I added the corresponding data to `db/seeds.rb`

## Writing unit tests for model

We have successfully generated seed data for our models but we still do not have tests.

Ideally I wanted to write the tests first before generating the model.

However, I knew that the non-standard primary keys would be tricky to implement so I focused on making that work first.

Now that is working, I'll write tests first before proceeding further to make sure I don't break anything moving forward.

We need to first add the `rspec` gem, and write tests related to each model.

We also need to install `factory_bot` and `faker` gem to help with the attributes for testing.
