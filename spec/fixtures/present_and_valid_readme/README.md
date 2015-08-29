# Code Along: Through Associations

```ruby
class Person 
  attr_accessor :name, :happiness, :partner

  def initialize(name)
    @name = name 
  end 
  
  def get_married(person)
    self.partner = person
    person.partner = self 
  end
```

Now, with those code, we can do the following:

```ruby
beyonce = Person.new("Beyonce")
jayz = Person.new("Jay-Z")

beyonce.get_married(jayz)

beyonce.partner.name 
  => "Jay-Z"
jayz.partner.name 
  => "Beyonce"
```

Now, we could say that the `beyonce` instance ***belongs to*** the `jayz` instance and that the `jayz` instance ***belongs to*** to the `beyonce` instance. 

Let's take a look at another example. This time, we'll build it out together: 

## Code Along I: Has Many and Belongs To

For this domain model we're taking a small trip back in time, to the '90s. We have two classes––`NinetiesTeen` and `CD`. Our `NinetiesTeen`agers will have the ability to have a CD collection. So, a teen will have many CDs and a CD will belong to a teen. This exercise introduces a new(ish) association for us––the "has many" association. In fact, we've seen this before. In a previous lab we built an `Owner` class and a `Pet` class. Owners had a collection of pets and individual pets could belong to an owner. 

### Step 1: Defining Our Models

Open up the `lib` directory and you'll see two files, `nineties_teen.rb` and `cd.rb`. Let's start by building out our `NinetiesTeen` class. That class should be initialized with a name that it takes in as an argument. It should also be initialized with an `@cd_collection` variable that is set equal to an empty array. While we're at it, let's make an `attr_accessor` for `name`. We need to greate an `attr_accessor` for `cd_collection`. This `attr_accessor` will hold the `@cd_collection` array for us. It knows to contain that array due to the super-smart naming conventions of Ruby. 

With our `cd_collection` `attr_accessor` in place, a teen can retrieve, or "get", their cd collection *and* add to, or "set" their cd collection. 

```ruby
class NinetiesTeen

  attr_accessor :name, :cd_collection

  def initialize(name)
    @name = name 
    @cd_collection = []
  end
end
```

We want our teens to be able to tell their friends about their awesome CD collection, so let's create a method, `my_cd_collection`, that allows them to `put`s out the names of each of their cds:
```ruby
class NinetiesTeen

  attr_accessor :name, :cd_collection

  def initialize(name)
    @name = name 
    @cd_collection = []
  end
  
  def my_cd_collection
    puts "My CD collection:"
    self.cd_collection.each do |cd|
      puts "#{cd.artist}: #{cd.title}"
    end
  end
end
```

### Step 2: Associations 

Okay, let's give our teens the ability to build up their collection. We'll define a `buy_cd` method  (which will obviously get called with a teen goes to Sam Goody) that takes in an argument of an instance of the `CD` class and adds it to our teen's `cd_collection` array: 

```ruby
class NinetiesTeen

  attr_accessor :name, :cd_collection

  def initialize(name)
    @name = name 
    @cd_collection = []
  end
  
  def buy_cd(cd)
    self.cd_collection << cd
  end
end
```

Alright, our teen instances now have the ability to **have many** cds. Now, we'll write our `CD` class and make sure that `CD` instances can **belong to** a teen. In order for that to happen, we need to give individual cds a `teen` `attr_accessor` that we can set equal to the teen that adds that cd to their collection

```ruby
class CD
  
  attr_accessor :title, :artist, :teen
  
  def initialize(title, artist)
    @title = title
    @artist = artist
  end
end
```

The code above allows us to create `CD` instances with a title and an artist. We also have a `.teen` and a `.teen=` method that we can use to tell an instance of the `CD` class that it belongs to an instance of `NinetiesTeen`.

Now that we have our `CD` class ready to go, we can preform the following actions: 

```ruby
teen = NinetiesTeen.new("Stacy")
tlc = CD.new("CrazySexyCool", "TLC")
savage_garden = CD.new("Affirmation", "Savage Garden")
teen.buy_cd(tlc)
teen.buy_cd(savage_garden)

teen.my_cd_collection
```

Open up `bin/first` file in this project and you'll see the above code. Run the file using `ruby bin/first` in your terminal, inside the directory of this project. You should see the following output: 


```bash
 "TLC: CrazySexyCool"
 "Savage Garden: Affirmation"
```

Okay, so we've created the *ability* for teens to have many cds and we've created the *ability* for cds to belong to a teen. Then, with the code above, we told a teen that she owned two cds. **But**, did we tell the cds that they belong to that teen? Let's check by calling `.teen` on our `CD` instances. If we were to call `.teen` on our `CD` instances, we would see the following. 

```ruby
tlc.teen
  => nil
savage_garden.teen
   => nil
```

Open up the `bin/second` file and take a look at that code. Run the file `bin/second` in your terminal to execute the above code. 

Hmmm, looks like the teen knows about her cds but the cds don't know about their teen. This actually makes perfect sense if we take another look at the `buy_cd` method that we built into our `NinetiesTeen` class: 

```ruby
def buy_cd(cd)
  self.cd_collection << cd
end
```

In this method, we are *only associating cds to a teen*. We are failing to tell the cds that they now *belong to* a teen. Let's fix that: 


```ruby
def buy_cd(cd)
  self.cd_collection << cd
  cd.teen = self
end
```

Let's try those associations again. Run the code in `bin/third` with the command `ruby bin/third` in your terminal. It will execute the same code we had in `bin/second`, but now that we've improved our `add_cd` method, we will see that our associations are complete! The code in `bin/second` reads:

```ruby
teen = NinetiesTeen.new("Stacy")
tlc = CD.new("CrazySexyCool", "TLC")
savage_garden = CD.new("Affirmation", "Savage Garden")
teen.buy_cd(tlc)
teen.buy_cd(savage_garden)

teen.my_cd_collection

savage_garden.teen.name
tlc.teen.name
```
When you execute it, you should see the following in your terminal: 


```bash
"TLC: CrazySexyCool"
"Savage Garden: Affirmation"
Stacy
Stacy
```

We did it! A teen can have many cds and each individual cd can belong to a teen. When a teen buys a cd, that cd is added to their collection and that cd has it's `.teen=` attribute set to an an instance of `NinetiesTeen`. 

#### A Note On Associations

You may be wondering why we chose to associate a teen to a cd inside the `buy_cd` `NinetiesTeen` instance method. Afterall, couldn't we instead use the following code to achieve the same effect?

```ruby
class CD

  ...
  
  def add_teen(teen)
    self.teen = cd
    teen.cd_collection << self
  end
end
```

Why choose to make the teen instances responsible for both buying a cd *and* adding themselves to that cd's `.teen=` attribute, instead of the other way around? As programmers, we want to write code that is sensical and easy for others to use. In object oriented programming, we can acheive that goal by writing code that is modeled on real-world environments and scenarios. In the real word, a CD can't hop off the shelf and into a teen's backpack (regardless of what a teen might say if caught walking out of Sam Goody with an unpaid-for CD in their backpack. However, a teen can *buy* a CD and thus take ownership of it. Because we want our program to reflect the real world, we will write it in such a way as to allow a teen to buy a CD, and in doing so become associated to it. 

Okay, now that we've covered the basics, we're ready to talk about **through associations**. 

## Code Along II: Through Associations 

Okay, we're going to complicate this a little further by adding another class into our domain model. Let's say it's actually the *late* '90s, MP3s are on the rise and Sam Goody's business isn't doing so hot. In order to bolster sales, they've started offering a $10 off coupon to their cusomters every time they buy a CD, to be applied to their next purchase. Let's build our `Coupon` class and give individual coupons the ability to be associated to CDs. 

### Step 1: Building the Model

Open up `lib/coupon.rb` and use the following code to define you class:

```ruby
class Coupon
  
  attr_reader :discount

  def initialize
    @discount = "$10 off!"
  end
end
```

Our `Coupon` instances are initialized with a discount of 10% and they have an `attr_reader` for `discount`. 

### Step 2: Building the Belongs To Association

Let's tell our CD's that they are associated to a coupon and our coupons that they are associated to a CD. In the `Coupon` class, we'll create a `cd` `attr_accessor`. 

```ruby
class Coupon
  attr_reader :discount
  attr_accessor :cd

  def initialize
    @discount = "$10 off!"
  end
end
```

Now we can call `.cd=` and `.cd` on an instance of the `Coupon` class. Let's do the same for our `CD` class: 

```ruby
class CD
  
  attr_accessor :title, :artist, :teen, :coupon
  
  def initialize(title, artist)
    @title = title
    @artist = artist
  end
  
end
```

Now we can call `.coupon=` and `.coupon` on an instance of the `CD` class. 

Let's think about how this association would play out in real life. According to the example we outline above, a CD gets a coupon associated to it *when someone buys it*. So, if we're sticking with this idea, we should associate coupons to CDs and vice versa in the `buy_cd` method on the `NinetiesTeen` class: 

```ruby
class NinetiesTeen

  attr_accessor :name, :cd_collection

  def initialize(name)
    @name = name 
    @cd_collection = []
  end
  
  def my_cd_collection
    puts "Here is my CD collection:"
    self.cd_collection.each do |cd|
      puts "#{cd.artist}: #{cd.title}"
    end
  end

  def buy_cd(cd)
    self.cd_collection << cd
    cd.teen = self
    new_coupon = Coupon.new
    cd.coupon = new_coupon
    coupon.cd = cd
  end
end
```

Okay, now that we have the ability to associate CDs and coupons *and* we've written the code that creates that association in the appropriate location, we're ready to think about that **through association**. 

### Step 3: Building the Through Association

Now, Sam Goodey might not be doing so hot financially, but that doesn't mean they are giving away coupons for free. A teen gets a coupon *when they buy a CD*. So, in a sense, a teen only has a collection of coupons *through* the CDs to which those coupons belongs. This is the core of the **through association:** an instance of `NinetiesTeen` can *have many* coupons, but any coupons that it has, it has *through* it's CDs. 

Let's build a method that will collect all of an individual teen's coupons. Remeber, in order to get at a teen's coupons, we have to go *through* their CDs. 

In the `NinetiesTeen` class, write the following method: 

```ruby
class NinetiesTeen 

  ...
  
  def my_coupons
    self.cd_collection.collect do |cd|
      cd.coupon
    end
  end
end
```

Now, if we call `.my_coupons` on an instance of `NinetiesTeen`, we'll return an array of that teen's coupons. Once you placed the above code in the `NinetiesTeen` class, run the code in the `bin/fourth` file. You'll see that we are successfully collecting and `puts`ing out our teen's coupons. 

## Final Code

If you had trouble following along and your code isn't behaving quite like it should, check out the final versions of our three classes below: 

#### `lib/cd.rb` 

```ruby
class CD
  
  attr_accessor :title, :artist, :teen, :coupon
  
  def initialize(title, artist)
    @title = title
    @artist = artist
  end

end
```

#### `lib/nineties_teen.rb`

```ruby
class NinetiesTeen

  attr_accessor :name, :cd_collection

  def initialize(name)
    @name = name 
    @cd_collection = []
  end
  
  def my_cd_collection
    puts "Here is my CD collection:"
    self.cd_collection.each do |cd|
      puts "#{cd.artist}: #{cd.title}"
    end
  end

  def buy_cd(cd)
    self.cd_collection << cd
    cd.teen = self
    new_coupon = Coupon.new
    cd.coupon = new_coupon
    new_coupon.cd = cd

  end

  def my_coupons
    self.cd_collection.collect do |cd|
      cd.coupon
    end
  end
end
```

#### `lib/coupon.rb`

```ruby
class Coupon
  attr_reader :discount
  attr_accessor :cd

  def initialize
    @discount = "$10 off!"
  end
end
```


## Conclusion

Now that we've had a basic introduction to some more complex associations, you'll be building a similar domain model in the next lab. If you feel a little shaky on some of these concepts, that's okay. These concepts are complex. But they are foundational. Give the next lab a try and remember to refer back to this walk-through for help. Even consider re-doing this Code Along if you don't yet feel confident enough to move on. And remember to always reach out to the Learn community for help!