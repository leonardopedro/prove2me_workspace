-- Generated from ChapterWeylSL2Group.lean — theorem BookProof.ChapterWeylSL2Group.pow_mem_of_mem
import Definitions.Def_ChapterWeylSl2
import Mathlib
import Definitions.Def_ChapterWeylSL2Group
open BookProof.ChapterWeylSL2Group



open BookProof.ChapterWeylSl2

universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V} {R : Sl2Rep V} {N : ℕ}

theorem BookProof.ChapterWeylSL2Group.pow_mem_of_mem {W : Submodule ℂ V} {a : Module.End ℂ V} (ha : ∀ x ∈ W, a x ∈ W)
    {v : V} (hv : v ∈ W) (k : ℕ) : (a ^ k) v ∈ W := by sorry
