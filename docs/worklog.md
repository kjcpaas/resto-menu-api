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

## Adding GraphQL

*At this point, I realized that I consumed more than half of the 8 hours alloted*.

I decided to forgo the CI/CD pipeline build at this point and priotitize building the GraphQL api.

I used https://www.apollographql.com/blog/using-graphql-with-ruby-on-rails as the main reference.

After adding the `graphql` and other related gems to the Gemfile,

GraphQL types were generated from their corresponding Rails model via:

```
rails g graphql:object <model_name>
```

### Testing

For testing GraphQL, I used these references:

https://jamesnewton.com/blog/how-i-test-graphql-in-rails-with-rspec
https://selleo.com/blog/testing-graphql-mutations-in-ruby-on-rails-with-rspec

I leaned towards the 2nd approach as it simulates actual request on the graphql endpoint.

Sample query in `spec/graphql/fixtures/**/*.gql` can also be used in GraphiQL

### Asking help from ChatGPT

Since I am running out of time, I asked ChatGPT for help in defining the the other fields for all models.

I asked to replicate my code for Menu for the other models.o

For the list queries
```{ruby}
field :menus, [Types::MenuType], null: false, description: 'Returns a the list of available menus'

def menus
  Menu.all
end
```

For the item queries (only for those with identifier field)
```{ruby}
field :menu, Types::MenuType, null: true, description: 'Returns menu with corresponding identifier' do
  argument :identifier, String, required: true
end

def menu(identifier:)
  Menu.find_by(identifier: identifier)
end
```

**Note:** Adding the test case for the requests and response for each of the models is ideal but very tedious.

However, I think I have demonstrated enough how this is done in `spec/graphql/types/query_type_spec.rb`

If I have enough time, I will generate the specs for the other models.

### Implementing the mutations

I have implemented the full CRUD for Menu.

As much as I want to go further, implementing the full CRUD for all models is not possible with the tme I have left.

However, the mutations I created are well-tested so I am confident that they are working well.

## Deployment

I originally wanted to implement a full CI/CD but seeing that I've run out of time, I'll just do a quick deploy with Heroku.

I did the deployment via git push using Heroku CLI.

The app is available at: https://resto-menu-api-3c61fad65343.herokuapp.com/graphiql

## Takeaways

I had pretty ambitious expectations going into this app. Some of them, I did not accomplish and some I improved beyond the specifications.

Overall, I enjoyed making this app!

### Successes

- Implementation of the models according to the provided ERD
- Validations, including custom ones
- Well-tested models
- Integrating GraphQL with RoR from scratch for the first time
- GraphQL queries for all models, including tests
    - The test did not cover all models as I ran out of time. However, I was able to write enough to demonstrate my learning an approach on this

### Misses

- Build CI/CD (nice to have)
- Setup devcontainers (nice to have)
- Mutations for all models
    - I was only able to implement the full CRUD for Menu
    - I wanted to implement swapping of display_order as well as I had some ideas around it
- I had to backtrack to model generation while seeding because I misunderstood the relation between Modifier and Item

### What I could have done differently

- Perhaps I should have negotiated to implement the identifier with the Rails default id (int type) as I spent too much time making it work with the customer primary and foreign keys.
    - However, I am proud that I did not give up even when I was frustrated along the way

- Do not spent to much time on generating the Menu seed. :sweat: I wanted to imagine a Menu I wanted to experience but I dove too deep into the rabbit hole.

- Use ChatGPT earlier to help in generating repeated code
    - I had a lot of duplicated work from typing. It would have been faster if I had used ChatGPT earlier easpecially for repeatable code. I formulated the logic myself anyway.
