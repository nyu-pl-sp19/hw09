# Homework 9 (20 Points)

The deadline for Homework 9 is Monday, April 22, 6pm. The late
submission deadline is Thursday, April 25, 6pm.

## Getting the code template

Before you perform the next steps, you first need to create your own
private copy of this git repository. To do so, click on the link
provided in the announcement of this homework assignment on
Piazza. After clicking on the link, you will receive an email from
GitHub, when your copy of the repository is ready. It will be
available at
`https://github.com/nyu-pl-sp19/hw09-<YOUR-GITHUB-USERNAME>`.
Note that this may take a few minutes.

* Open a browser at `https://github.com/nyu-pl-sp19/hw09-<YOUR-GITHUB-USERNAME>` with your Github username inserted at the appropriate place in the URL.
* Choose a place on your computer for your homework assignments to reside and open a terminal to that location.
* Execute the following git command: <br/>
  ```git clone https://github.com/nyu-pl-sp19/hw09-<YOUR-GITHUB-USERNAME>.git```<br/>
  ```cd hw09```


### Implementing Multisets (20 Points)

Multisets (aka bags) are sets in which elements can appear multiple
times. For example, the multiset *{a, a, b, b, b}* contains *a* twice
and *b* three times. Formally, a multiset *m* over a *base set* of
elements *U* can be viewed as a function *m: U → ℕ* that associates
every element *x ∈ U* with its *multiplicity*,  *m x*. That is, if *U =
{a,b,c}* then the multiset *{a, a, b, b, b}* is represented by the
function *{a ↦ 2, b ↦ 3, c ↦ 0}*.

Let *MSet(U)* denote the set of all such functions, i.e. the set of
all multisets over *U*. We consider the following operations on
multisets:

* `count`: *MSet(U) → U → ℕ*

  `count` *m x* = *m x*

* `empty`: *MSet(U)*

  `empty` = *λ x ∈ U. 0*

* `add`: *MSet(U) → U → MSet(U)*

  `add` *m y* = *λ x ∈ U. if x = y then m x + 1 else m x*

* `remove`: *MSet(U) → U → MSet(U)*

  `remove` *m y* = *λ x ∈ U. if x = y then max 0 (m x - 1) else m x*

* `union` *MSet(U) → MSet(U) → MSet(U)*

  `union` *m1 m2* = *λ x ∈ U. max (m1 x) (m2 x)*

* `inter` *MSet(U) → MSet(U) → MSet(U)*

  `inter` *m1 m2* = *λ x ∈ U. min (m1 x) (m2 x)*

* `diff` *MSet(U) → MSet(U) → MSet(U)*

  `diff` *m1 m2* = *λ x ∈ U. max 0 (m1 x - m2 x)*

* `sum` *MSet(U) → MSet(U) → MSet(U)*

  `sum` *m1 m2* = *λ x ∈ U. m1 x + m2 x*

* `equal` *MSet(U) → MSet(U) → 𝔹*

  `equal` *m1 m2* = *∀ x ∈ U. m1 x = m2 x*
  
Our goal is to implement modules and functors for a simple library of
multisets. We will consider two possible implementations that will
have slightly different advantages and disadvantages.

### Part 1: A polymorphic multiset module (8 Points)

In this part, we will implement multisets as a single module that
provides a polymorphic type for representing multisets over arbitrary
base sets *U*. All the code related to this part should go into the
files `src/part1.ml` and `src/hw09_spec.ml`.
  
1. Declare a module type `MultisetType` that describes
   multisets and their associated operations as outlined above. Use a
   polymorphic type

   ```ocaml
   type 'u t
   ```

   to represent the set `MSet(U)` where the type parameter `'u` stands
   for the base set `U` over which the multisets are defined.  Your
   signature should include all of the multiset operations given above
   with the OCaml equivalents of their specified types. Make sure that
   the signature does not expose how the type `'u t` is implemented.

2. Write a module `Multiset` that implements the signature
   `MultisetType` such that the behavior of the multiset operations is
   consistent with the abstract specifications given above. There are
   many possible choices that you can make for implementing the type
   `'u t` in OCaml. The specific choice is up to you.

3. Write some unit tests for testing your implementation. The provided
   build script `build.sh` assumes that all testing code is in the
   file `src/hw09_spec.ml`. You can compile and run the code as in
   previous homework assignments.

   

### Part 2: A multiset functor over an ordered base set (8 Points)

Instead of implementing multisets as a single module that provides a
polymorphic type representing multisets for arbitrary base sets *U*,
we now take a different approach and implement multisets as a
functor. This allows us to impose additional constraints on the
structure of the base set *U* giving us more flexibility in the
implementation (at the cost of having to create a new multiset module
for every base set). Specifically, we will assume that the base
set `U` is represented by a module that satisfies the signature of an
`OrderedType` which we have already seen in class:

```ocaml
module type OrderedType = sig
  type t
  val compare: t -> t -> int
end
```

We will proceed again in multiple steps. All the relevant code for
this part should go into the files `src/part2.ml` and
`src/hw09_spec.ml`.

1. As a first step, write again a module signature `MultisetType` that
   describes multisets and their operations. However, unlike in the
   previous part, the module should now declare two abstract types
   
   ```ocaml
   type u
   type t
   ```
   
   where `t` represents `MSet(U)` and `u` represents `U`. That is,
   unlike in Part 1, every module implementing this signature will fix
   the base set to a specific type `u` rather than keeping it
   polymorphic.

2. Write a functor called `Make` that takes in a module satisfying the
   signature `OrderedType` and returns a module satisfying
   `MultisetType` such that the type `u` of the latter is equal to
   the type `t` of the former. Again, make sure that your
   implementation of the multiset operations is consistent with their
   abstract specifications given above.

   **Hint:** Similar to the polymorphic multiset implementation, there
   are many possible ways to implement the type `mset`. However, I
   suggest to use maps over ordered keys, which are provided by the
   OCaml standard library. This choice also simplifies Part 3.
   
   OCaml's standard library provides a functor
   [`Map.Make`](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Map.Make.html)
   that takes a module `O: OrderedType` representing a totally ordered
   set `O.t` as input and returns a module of the signature
   [`Map.S`](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Map.S.html)
   representing maps from keys in `O.t` to values in `'a` for
   arbitrary types `'a`. Think about how to use this functor to create
   a map module from `O` that you can then use to implement the type `t`.

3. Again, write some unit tests for testing your implementation.

### Part 3: Ordered Multisets (4 Points)

All the relevant code for this part should go into the files
`src/part3.ml` and `src/hw09_spec.ml`.

One advantage of our functor implementation of multisets is that we
can use the additional structure provided by the module that
represents the base set to implement additional functionality on the
derived multisets. In particular, we can lift the ordering on the
base set to an ordering on multisets. 

There are many ways in which one can define an ordering on
multisets. A particularly important one is the [Dershovitz-Manner
ordering](https://en.wikipedia.org/wiki/Dershowitz%E2%80%93Manna_ordering).

Given a strict (partial) ordering *x < y* on the elements *x,y ∈
U*, we can lift this ordering to an ordering *m1 < m2* on multisets
*m1, m2 ∈ MSet(U)* as follows: *m1 < m2* holds iff

* *m1* and *m2* are different (i.e. `equal` *m1 m2* = `false`), and

* for every element *x ∈ U* which occurs more times in *m1* than
  in *m2*, there exists an element *y ∈ U* which occurs more times
  in *m2* than in *m1* and *x < y*.

For example, consider multisets over natural numbers *MSet(ℕ)*. Let

*m1 = {1, 1, 1, 2, 2}*

*m2 = {1, 1, 3}*

*m3 = {1, 1, 2, 2}*

then for the lifting of the standard ordering on *ℕ* to *MSet(ℕ)* we
have *m1 < m2*, *m3 < m2*, and *m3 < m1*. Note that *m3 < m1* holds
because there exists no *x ∈ ℕ* such that *x* occurs more often in
*m3* than in *m1*. On the other hand, *m1 < m2* holds because 3 occurs
more often in *m2* than in *m1* and is larger than all elements that
occur in *m1*.

The Dershovitz-Manner ordering has many nice properties. In
particular, it is total (well-founded) iff the ordering on the base
set is total (well-founded).

1. Write a module type `OrderedMultisetType` that extends
   `MultisetType` from Part 2 with an additional function
   
   ```ocaml
   val compare: t -> t -> int
   ```
   
   that represents the `compare` function for the `Dershovitz-Manner
   ordering` on multisets. The module type `OrderedMultisetType`
   should additionally have all the types and operations provided by
   `MultisetType`. Instead of copy/pasting the corresponding
   declarations, learn how to use the [`include`
   directive](https://caml.inria.fr/pub/docs/manual-ocaml/modtypes.html)
   to textually include a signature in another one.
   
   
2. Write a functor called `Make` that takes in a module
   satisfying the signature `OrderedType` and returns a module
   satisfying `OrderedMultisetType` such that the type `base` of the
   latter is equal to the type `t` of the former. Moreover, your
   implementation of `compare` should satisfy the following
   constraints for all multisets *m1* and *m2*
   
   i. `compare` *m1 m2* = 0 if *m1* and *m2* are equal (according to
   `equal`).
   
   ii. `compare` *m1 m2* is negative if *m1 < m2* holds
   
   iii. `compare` *m1 m2* is positive if *m2 < m1* holds
   
   Rather than reimplementing the remaining multiset operations again
   from scratch build on your work of Part 2. That is, use the functor
   `Part2.Make` to construct a module that implements all operations
   in `Part2.ModuleType` and then use [module
   inclusion](https://ocaml.org/learn/tutorials/modules.html#Module-inclusion)
   to add those operations to the module constructed by the new
   functor `Part3.Make`.
 
   Feel free to add additional functions to the module signature
   `Part2.ModuleType` if they help with the implementation of
   `compare` (e.g. to expose some of the iterator functions provided
   by `Map.S`) and then implement these functions in `Part2.Make`.
 
3. Again, write some unit tests for testing your implementation.

