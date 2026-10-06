-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.mem_scalarOps
import Mathlib
import Definitions.Def_ChapterWeylSl2
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

set_option maxHeartbeats 1000000 in
theorem solution {W : Submodule ℂ V} {f : Module.End ℂ V} :
    f ∈ scalarOps W ↔ (∀ v : V, f v ∈ W) ∧ ∃ c : ℂ, ∀ w ∈ W, f w = c • w := Iff.rfl
