open OUnit2
open Part1
  
type my_u = A | B | C

(** Part 1 tests *)

let m1 =
  Multiset.(add empty C)
  
let m2 =
  Multiset.(add (add empty C) A)

let m3 =
  Multiset.(add (add (add empty C) A) A)


let part1_count_tests =
  (* multiset, base element, expected result for count *)
  [Multiset.empty, A, 0;
   Multiset.empty, B, 0;
   Multiset.empty, C, 0;
   m1, A, 0;
   m1, B, 0;
   m1, C, 1;
   m2, A, 1;
   m2, B, 0;
   m2, C, 1;
   m3, A, 2;
   m3, C, 1;
   m3, B, 0]

let part1_count_suite =
  List.map (fun (m, x, expected_result) ->
    let name = "count" in
    name >::
    fun tc ->
      assert_equal expected_result (Multiset.count m x))
    part1_count_tests


let part1_suite =
  "Part 1 suite" >:::
  part1_count_suite

let _ = run_test_tt_main part1_suite

(** Part 2 tests *)

module MyMultiset = Part2.Make(struct
  type t = my_u
  let compare x y = match x, y with
  | A, (B | C)
  | B, C -> -1
  | C, (A | B)
  | B, A -> 1
  | _ -> assert (x = y); 0
end)

let m1 =
  MyMultiset.(add empty C)
  
let m2 =
  MyMultiset.(add (add empty C) A)

let m3 =
  MyMultiset.(add (add (add empty C) A) A)


let part1_count_tests =
  (* multiset, base element, expected result for count *)
  [MyMultiset.empty, A, 0;
   MyMultiset.empty, B, 0;
   MyMultiset.empty, C, 0;
   m1, A, 0;
   m1, B, 0;
   m1, C, 1;
   m2, A, 1;
   m2, B, 0;
   m2, C, 1;
   m3, A, 2;
   m3, C, 1;
   m3, B, 0]

let part2_count_suite =
  List.map (fun (m, x, expected_result) ->
    let name = "count" in
    name >::
    fun tc ->
      assert_equal expected_result (MyMultiset.count m x))
    part1_count_tests


let part2_suite =
  "Part 2 suite" >:::
  part1_count_suite

    
let _ = run_test_tt_main part2_suite


(** Part 3 tests ... *)
