-- Generated from ChapterWeylSl2.lean — theorem BookProof.ChapterWeylSl2.Sl2Rep.ops_zero_of_minimal_cas_zero
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Definitions.Def_ChapterDoubleSlit
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterDoubleSlit
open BookProof.ChapterGleasonPureMixed
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2



universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

theorem BookProof.ChapterWeylSl2.Sl2Rep.ops_zero_of_minimal_cas_zero [FiniteDimensional ℂ V] {W : Submodule ℂ V}
    (hW : R.IsInv W) (hne : W ≠ ⊥) (hmin : ∀ U ≤ W, R.IsInv U → U = ⊥ ∨ U = W)
    (hcas : ∀ x ∈ W, R.cas x = 0) : ∀ x ∈ W, R.E x = 0 ∧ R.F x = 0 ∧ R.H x = 0 := by sorry
