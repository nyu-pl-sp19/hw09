module type OrderedMultisetType = sig
  type u
  type mset

  (* add declarations of ordered multiset operations below *)
  
end

module Make(O: Map.OrderedType) : OrderedMultisetType (* adding missing where clause *) = struct
  (* add your implementation code here *)
end

