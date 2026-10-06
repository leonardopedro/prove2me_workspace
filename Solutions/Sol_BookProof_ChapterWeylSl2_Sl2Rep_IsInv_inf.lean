-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.IsInv.inf
import Mathlib
import Definitions.Def_ChapterWeylSl2
open BookProof.ChapterWeylSl2




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

set_option maxHeartbeats 1000000 in
theorem solution {R : Sl2Rep V} {U W : Submodule ℂ V} (hU : R.IsInv U) (hW : R.IsInv W) :
    R.IsInv (U ⊓ W) :=
  ⟨fun x hx => ⟨hU.1 x hx.1, hW.1 x hx.2⟩, fun x hx => ⟨hU.2.1 x hx.1, hW.2.1 x hx.2⟩,
      fun x hx => ⟨hU.2.2 x hx.1, hW.2.2 x hx.2⟩⟩
