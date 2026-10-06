-- Generated from ChapterWeylSL2Group.lean — theorem BookProof.ChapterWeylSL2Group.rho_mem_of_unipotent_inv
import Definitions.Def_ChapterWeylSl2
import Mathlib
import Definitions.Def_ChapterWeylSL2Group
open BookProof.ChapterWeylSL2Group

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V} {R : Sl2Rep V} {N : ℕ}



open BookProof.ChapterWeylSl2

universe u


theorem BookProof.ChapterWeylSL2Group.rho_mem_of_unipotent_inv {W : Submodule ℂ V}
    (hplus : ∀ (t : ℂ), ∀ v ∈ W, rho (uPlus t) v ∈ W)
    (hminus : ∀ (t : ℂ), ∀ v ∈ W, rho (uMinus t) v ∈ W)
    (g : Matrix.SpecialLinearGroup (Fin 2) ℂ) : ∀ v ∈ W, rho g v ∈ W := by sorry
