# Zero Cool

Mess with the best, die like the rest.

## Installation

It's a ruby gem, you know how to do this already:

    $ gem install zero_cool

Or if you're a weirdo and use Bundler, then do:

    $ echo "gem 'zero_cool'" >> Gemfile && bundle install

## WTF?

-- serious voice --

Just like Markov-chain generators create nonsense text that looks like it was
written by a human, Zero Cool creates blocks of nonsense programming language
code that, at quick glance, looks totally kosher.

Nearly all programming languages share the same basic components (functions,
loops, methods, classes, operators, arguments, ad nauseum) and so you can
create a procesing engine for generating code in a particular language. All
the human needs to do is to define the component types, their relationships
and come up with funny keyword names.

-- end of seriousness --

## Example Ruby Output

```ruby
class OriginOutputManager < ActiveSupport::Concern
  require 'directory_writer'
  include DatabaseStreamModel

  def save_after_create_after_validate_by_remote_before_pull  
    plugh!
  end

  def bind_at_calculate (purchase)
    waldo = 42
    grault = 89
    grault!
  end

  def pull_on_calculate_with_origin
    xyzzy = PurposeStreamManager.first!
    xyzzy!
  end

end

class DatabaseCreatorMigration
  
  def bind_after_validate_after_save_to_pull_on_remote!
    bar!
    return true
  end

  def remote_before_origin_after_validate (options=UserWriterFactory.create)
    raise MajourWarningException, "argument was not boolean" unless garply.empty?
    qux!
    waldo = DatabaseStreamManager.first
    return nil
  end

end

```
    
## Usage

** NOTE: NONE OF THIS ACTUALLY WORKS YET **

One day there will be instructions on using the command-line tool, the gem,
and documentation about how to build your own rule set to generate code
in other programming languages.

## Contributing

You think you're hardcore enough to improve this?  Then you must be
31337 enough to hack the Gibson with your P6 chip and change the code
yourself. What, did your mom buy you a 'puter for christmas?

## License

Distributed under a license that's just like GPL v2.0, except if you break 
the terms I'll hack your HR Department's database and have you declared...

    Dead.

        What?

    Like "rigor mortis", "habeas corpus".

        Very Impressive.

        Superhero-like, even.