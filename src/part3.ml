module type OrderedMultisetType = sig
  (* add declarations of ordered multiset types and operations below *)
  
end

module Make(O: Map.OrderedType) : OrderedMultisetType (* adding missing with clause *) = struct
  (* add your implementation code here *)
end

