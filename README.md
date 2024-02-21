## Content

This boilerplate comes with batteries included, you’ll find:

- [Phoenix](https://phoenixframework.org)
- Database integration with [Ecto](https://github.com/elixir-ecto/ecto)
- Translations with [Gettext](https://github.com/elixir-gettext/gettext)
- Tests factories using [ExMachina](https://github.com/thoughtbot/ex_machina) and code coverage using [ExCoveralls](https://github.com/parroty/excoveralls)
- CORS management with [CorsPlug](https://github.com/mschae/cors_plug)
- Static code analysis with [Credo](https://github.com/rrrene/credo)
- Releases using [`mix release`](https://hexdocs.pm/mix/Mix.Tasks.Release.html) and [Docker](https://www.docker.com)
- [Tailwindcss](https://tailwindcss.com/)

## Configurations

- warnings_as_errors: true

## Useful libraries

Here is an opinionated list of other useful libraries to consider:

| Category                    | Libraries                                                                              |
| --------------------------- | -------------------------------------------------------------------------------------- |
| Authentication              | [`ueberauth`](https://github.com/ueberauth/ueberauth)                                  |
| Token based auth            | [`Guardian`](https://github.com/ueberauth/guardian)                                    |
| Emails                      | [`bamboo`](https://github.com/thoughtbot/bamboo), [`swoosh`](https://github.com/swoosh/swoosh) |
| HTTP client                 | [`Tesla`](https://github.com/teamon/tesla)                                   |
| Job processing              | [`Oban`](https://github.com/sorentwo/oban)
| Pagination                  | [`Scrivener`](https://github.com/drewolson/scrivener) (limit/offset), [Quarto](https://github.com/maartenvanvliet/quarto) (cursor based)|
| Mocks                       | [`Mox`](https://github.com/dashbitco/mox), [`Mimic`](https://github.com/edgurgel/mimic)   |
| Cache                       | [Cachex](https://github.com/whitfin/cachex), [Nebulex](https://github.com/cabol/nebulex) (distributed cache)   |
| Date/Time                   | [Timex](https://github.com/bitwalker/timex)                                                         |
| CSV                         | [NimbleCSV](https://github.com/dashbitco/nimble_csv), [CSV](https://github.com/beatrichartz/csv)  |
| Feature Flags/Toggles       | [FunWithFlags](https://github.com/tompave/fun_with_flags)                             |
| Clustering                  | [libcluster](https://github.com/bitwalker/libcluster)                                 |

## Rename your project
1. Run `rename.sh` with the camel case name of your project

```
./rename.sh MyNewProjectName

```

## Development with Docker

### Dependencies

1. Install [Docker](https://www.docker.com/products/docker-desktop)
2. Install Make: `sudo apt install make` or `brew install make`

### First run

1. Clone the project repository: `git clone git@github.com:MAGICMOTORSPORT/elixir-boilerplate.git`
2. Go to project dir: `cd elixir-boilerplate`
3. Execute: `make setup` to install dependencies, setup the database, execute migrations, etc.
4. Get a `.env` file executing `cp env.template .env` and set the `SECRET_KEY_BASE` value. Get a new value executing `make gen.secret`
5. Execute: `make run` to run the server at http://localhost:4000
### New environment variables

If you want to add new environment variables you need to put the new env var in some places:

1. In the `.env.dist` template file to include in new installations
2. In your `.env` file

NOTE: When you add a new env var you must restart the container, so the container can read the new variable.
### Makefile

For convenience, you can use the commands included in the Makefile:

| Command                                                           | Description                                           |
| ----------------------------------------------------------------- | ----------------------------------------------------- |
| `make bootstrap`                                                  | Bootstrap the phoenix project (dependencies & databse)|
| `make deps.get`                                                   | Gets & compile dependencies                           |
| `make deps.clean`                                                 | Clean unused dependencies & remove from mix.lock      |
| `make seeds`                                                      | Run seeds                                             |
| `make reset`                                                      | Resets the project removing deps & builds             |
| `make ecto.setup`                                                 | Setup the database for dev                            |
| `make ecto.reset`                                                 | Resets the database for dev                           |
| `make ecto.reset.test`                                            | Resets the database for test                          |
| `make test`                                                       | Runs tests                                            |
| `make check.all`                                                  | Run all CI verifications (formatter, credo, coverage) |
| `make run`                                                        | Start **Phoenix** server                              |
| `make gettext`                                                    | Search & merge new translations                       |
| `make format`                                                     | Format all phoenix files                              |

## Development without Docker

### Dependencies

1. Install [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)
2. Add the [asdf erlang plugin](https://github.com/asdf-vm/asdf-erlang) `asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git`
3. Add the [asdf elixir plugin](https://github.com/asdf-vm/asdf-elixir) `asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git`
4. Add the [asdf nodejs plugin](https://github.com/asdf-vm/asdf-nodejs) `asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git`
### First run

1. Clone the project repository: `git clone git@github.com:MAGICMOTORSPORT/elixir-boilerplate.git my_app`
2. Go to project dir: `cd my_app`
3. Install Erlang, Elixir & NodeJS using the `.tools-versions` file with: `asdf install`
4. Copy the `env.dist` file to `.env` and set the `SECRET_KEY_BASE` value. Get a new value executing `mix phx.gen.secret`.
5. Run `export $(cat .env | xargs)` on project root folder
6. Run `mix local.hex && mix local.rebar`
7. Run `mix setup` to download dependencies & setup database
8. Run `mix phx.server`

### New environment variables

If you want to add new environment variables you need to put the new env var in some places:

1. In the `.env.dist` template file to include in new installations
2. In your `.env` file.
# AppName

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Phoenix Contexts

In Phoenix, contexts often encapsulate data access and data validation. They often talk to a database or APIs. Overall, think of them as boundaries to decouple and isolate parts of your application.

Contexts are modules and functions defining the public interface of your application.

The choices about how to draw contexts in your application must be rooted in DDD (Domain Driven Development)

In Phoenix contexts can also act as a encapsulation of something that tomorrow can be extracted in a separate microservice. 

Naming things is hard. If you're stuck when trying to come up with a context name when the grouped functionality in your system isn't yet clear, you can simply use the plural form of the resource you're creating. For example, a `Products` context for managing products. As you grow your application and the parts of your system become clear, you can simply rename the context to a more refined one.

Contexts act as that reusable layer for business logic. The names of modules/functions/parameters should reflect business domain concepts.

Phoenix contexts can easily become quickly huge meatballs of code, to ease things out, we decide to split them into layers:

    Public Context (the actual Context, the public API)
    Schema (including changesets and validations)
    Queries

Here’s what that might look like:

```
├── posts/
│   ├── posts.ex
│   ├── post_schema.ex
│   ├── post_queries.ex
├── complex_context/
│   ├── schemas/
│   ├── queries/
│   ├── sub_complex_context/
│   ├── complex_context.ex
├── utils/
│   ├── util_a.ex
│   ├── util_a_test.exs
│   └── ...
└── ...

```

The **Schema** layer (`post_schema.ex`) covers the Ecto schema, with changesets and validations. Now you can see easily which database schemas are in the context. The idea is to have something near to a OO Model without database interactions.

The **Queries** layer (`post_queries.ex`) handles all the database operations, excluding validation. It’s for internal use within its context only. Can be split into schema based files.

The **Public Context** layer (`posts.ex`) is the context’s public API to the rest of your app. Here, you’ll find business logic beyond queries or validation.

Being an interface the public context can be made only of `defdelegate` functions calling the queries layer. https://hexdocs.pm/elixir/1.12/Kernel.html#defdelegate/2

Splitting contexts into subcontextes like this and using `defdelegate` in the context module can help have all the public interface in one place and at the same time better manage code at the subcontext level.

It’s totally ok for contexts to talk to each other so long as it’s happening through the “aggregate root” (ie, the context file, even if this isn’t the 100% true definition).

Also when facing inter contexts operations `Services` can be used. Services must return an `Ecto.Multi` from call so that they can be composed together (see documentation resource [4])


### Documentation

[1] https://hexdocs.pm/phoenix/contexts.html
[2] https://curiosum.com/blog/elixir-phoenix-context-maintainability-guildelines
[3] https://michal.muskala.eu/post/putting-contexts-in-context/
[4] https://luizdamim.com/blog/reorganizing-your-phoenix-contexts-as-use-cases/
[5] https://speakerdeck.com/andrewhao/building-beautiful-systems-with-phoenix-contexts-and-ddd?slide=151

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
