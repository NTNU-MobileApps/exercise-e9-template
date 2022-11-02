# Exercise E9

Repository for exercise E9.
Course [IDATA2503 Mobile applications](https://www.ntnu.edu/studies/courses/IDATA2503)
at [NTNU](https://ntnu.edu), campus [Aalesund](https://www.ntnu.edu/alesund).

## Intention

The intention is to practice writing unit tests and widget tests.

## Hand-in process

This is an optional exercise, no need to hand in anything.

## Background

Here in this repo you have a Flutter application with a ready-to-use user interface (UI). Your task
is to write tests for it. During the process you will discover a bug and fix it.

The application is a "product page" of an online show, where the user sees one particular product: a
t-shirt. The user can click on the shopping cart icon at the top-right and see the items currently
in the cart. This UI has a limited version of the UI presented in E9.

## Instructions

The exercise consists of three parts: basics, unit tests and widget tests.

### Part 1 - Flutter testing 101 (the basics)

Let's start with the basics:

1. Create a folder called `test` inside the project. This is the default location for test files.
   You can create sub-folders if necessary. You can place tests anywhere actually, but if you want
   them to be "found automatically", the `test` folder is the place.
2. Now open the terminal and run `flutter test` command. You will probably see the following
   message:
   ```
   Test directory "test" does not appear to contain any test files.           
   Test files must be in that directory and end with the pattern "_test.dart".
   ```
   That's because we don't have any test files yet.
3. Inside the `test` folder create file `cart_item_test.dart`. If you run the `flutter test` command
   now, you should see a different error message. This time it should
   say `loading .../cart_item_test.dart` - this is a good sign - the test file has been found. But
   then the test will fail with an error message
   ```
   Error: Undefined name 'main'.
   await Future(test.main);
   ```
   Each test file is expected to have a `void main` function (which can be asynchronous). All the
   tests should be placed inside the `main`. Let's do that in the next step.
4. Insert the following code inside the `cart_item_test.dart` file:
   ```
   void main() {
     print("Launching CartItem tests...");
   }
   ```
   Now you should see output similar to this one:
   ```
   00:06 +0: loading D:\repos\exercise-e9\test\cart_item_test.dart
   Launching CartItem tests...
   No tests ran.
   No tests were found.
   ```
   The tests "succeed" just that there are no tests yet.
5. Let's add our first test. This one will not do any useful work. It's just a proof of concept to
   get familiar with the syntax of running unit tests. Inside the `main` function, place the
   following code:
   ```
   test("Hello, testing", () {
    expect(6 * 7, equals(42));
   });
   ```
   You will also need to import the `flutter_test` package by adding the following line at the top
   of the file (your IDE should help you do it automatically):
   `import 'package:flutter_test/flutter_test.dart';`
6. If you run `flutter test` in the terminal now, you should see a message `All tests passed!`.
   Congrats, you have written and executed a unit test in Flutter.
7. Now let's take a look a bit at what we wrote. Inside the main function we call the `test()`
   function with two parameters. The first parameter is the name of the test. The second parameter
   is a function which represents the test. One interesting fact is that the test is NOT executed at
   the time when the `test` function is executed. The `test` function is basically just "registering
   a new test in the test list". The execution of the test itself (this function including
   the `expect(6 * 7, equals(42));`) is run "sometime later" by the test framework. I.e., you should
   not assume that the tests:
    1. Get executed right away.
    2. Are executed in exactly the sequence you wrote them inside the main function.
    3. Are executed sequentially. I.e., several tests CAN be executed in parallel. Usually they are
       not, but they can.
8. Inside the test function body, you can create local variables, call functions etc - do whatever
   you need to create the logic you want. For example, you can write the following code inside
   the `main` function:
   ```
   test("CartItem constructor test", () {
     CartItem item1 = CartItem("Shoes", "Large", 2);
     CartItem item2 = CartItem("Hat", "Small", 1);
     expect(item1.name, equals("Shoes"));
     expect(item2.count, lessThan(item1.count));
   });
   ```
   This test creates two `CartItem` objects and tests some of the expectations about the
   constructor.

Now let's talk a bit about the `expect` function. Inside tests you write your _assertions_ - what do
you _expect_ to be true inside each test? In this case, we expect, that 6 * 7 is equal to 42. Inside
your tests you can expect that a function returns a specific value, that a widget of specific type
is found currently "on the screen", etc. You write each of the expectations (assertions) by calling
the `expect` function. This function takes three parameters, where the third one is optional:

1. The actual value - generated by the code you want to test. This would be result of a function,
   etc.
2. The expected value, or more broadly - a matcher. The matcher is itself a function. There are
   several different matchers. Some examples:
    1. `equals(expectedVal)` - check if the actual value matches the `expectedVal`. You see an
       example in the test we wrote.
    2. `isNotNull` - a matcher saying "hey, I expect that the actual value is not null".
    3. `greaterThan(threshold)` - a matcher saying "I expect "`value > threshold`,
    4. you can find
       other [matchers in the documentation](https://api.flutter.dev/flutter/package-matcher_matcher/package-matcher_matcher-library.html)
       .
3. An optional named parameter `reason` - here you can write an error message that will be given to
   the developer in case the test fails.

Note: the default matcher is `equals`. For example, you can write `expect(6 * 7, 42)` - this is
equivalent to `expect(6 * 7, equals(42))`;

At this point you should be familiar with the basic concepts of testing in Flutter. You define tests
with the `test` function, inside the test function you write some code for simulating the situation
you want, then you use the `expect` function to express all your expectations about the results.

## Part 2 - Unit tests

Now that you know how unit tests are written, your task is to write a unit test which checks one
expectation. During the process you will discover that the actual code does not satisfy the
requirement. This is one example of how writing a test can uncover bugs and incomplete code.

Write a test for the following expectation: _`CartItem.fromMap(data)` function returns null if any
of the expected fields in the provided `data` map is missing_. The expected fields are: `name`
, `size`, and `count`. An example: `CartItem.fromMap({"name": "Shoes", "size": "43"})` must return
null, because it is missing the `count` attribute.

When you execute the test, you will find out that the `CartItem.fromMap` function does not satisfy
the expectation. Then you do what a responsible programmer does - when you encounter a bug, go and
fix it! :) Afterwards, run the tests and make sure you get a green test. Isn't it good to see tests
passing? ;)

Hints:

* You probably want to call the `CartItem.fromMap` function with data missing some parameters. It is
  suggested to create one expectation for each parameter. I.e., one call of the `fromMap` function
  when the `name` attribute is missing, one with missing `size`, one with missing `count`.
* Then do an expectation check for each function call.
* The `isNull` matcher can be handy. It is equivalent to `equals(null)` but is perhaps a bit more
  readable, because `expect(c, isNull)` is quite close to "I expect that c is null" - we write code
  close to natural language.

## Part 3 - Widget tests

Running tests involving widgets is a bit more complicated. The theory is too long to be simply
explained in a text here. Go and watch the Udemy videos (see relevant video numbers on Blackboard).

The task in this step is to create a unit test which checks the following expectation:
_When the user clicks on the cart icon, she is taken to the `ShoppingCartPage`_.

Create a new file `test/widget_test.dart` and create a test which checks the provided expectation.

Note: while the Udemy videos show a quite complicated procedure how to write tests involving
navigation, you can simplify the procedure. Instead of expecting that _"a `ShoppingCartPage` widget
is pushed onto the navigation stack"_, you can simply expect that _"a `ShoppingCartPage` widget is
visible inside the application"_.

Try to run the test. You will discover that our developer has been _sloppy_ again and has forgotten
to bind the on-tap event of the shopping cart icon with the navigation to the cart page. Fix this!
Hint: the developer was kind enough to provide the function `_showShoppingCartPage` inside
the `ProductPage` class. This may be handy.

Hints:

* It is probably easiest to _pump_ the whole `MyApp` widget. `ProductPage` is the default home page
  there.
    * You can _pump_ the `ProductPage` widget, but in that case remember to place it inside
      the `MaterialApp` widget
* Use `await` in all the necessary places
* Call the necessary `pump`, `pumpAndSettle`, `tap`, etc.
* You can search the "open the cart" icon by `Key("open_cart_icon")`.
* To make sure you correctly found the icon-button, you should probably use the `findsOneWidget`
  expectation.
* Use the `find` function to check for presence of widgets.
    * You can probably use the `find.byType` function
* After you have fixed the code (set the `onPressed` callback), the `IconButton` is not constant
  anymore, make sure you remove the necessary `const` keywords in code. Otherwise the code won't
  compile.