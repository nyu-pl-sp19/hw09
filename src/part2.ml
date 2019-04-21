module type MultisetType = sig
  type u (** represents base set U *)
  type t (** represents MSet(U) *)

  (* add declarations of multiset operations below *)
  
end

module Make(O: Map.OrderedType) : MultisetType (* add missing with clause *) = struct
  (* add your implementation code here *)
end
