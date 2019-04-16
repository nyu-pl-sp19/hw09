module type MultisetType = sig
  type u
  type mset

  (* add declarations of multiset operations below *)
  
end

module Make(O: Map.OrderedType) : MultisetType (* add missing where clause *) = struct
  (* add your implementation code here *)
end
