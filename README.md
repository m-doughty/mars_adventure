# MarsAdventure

## Description

Parses a text input and simulates robot movements across a grid.

(Code aptitude test solution)

## Todo

- Move robot
- Move multiple robots sequentially
- Implement loss detection & stop running instructions on loss
- Implement location scenting & ignore instructions which would lead to loss on scent markers
- Parse and validate input into world and robots with instructions

## Installation

You'll need Elixir installed, along with the Mix tool.

Clone the repository:

```
git clone https://github.com/m-doughty/mars_adventure.git
```

Then cd into the repository, install dependencies and compile:

```
cd mars_adventure
mix deps.get
mix compile
```

## Running Tests

To run dialyzer (type checking):

```
mix dialyzer
```

To run the unit tests:

```
mix test
```

## Running the Application

First compile the executable:

```
mix escript.build
```

Then run the application with the robot instructions in a file:

```
./mars_adventure --file=instructions.txt
./mars_adventure -f instructions.txt
```