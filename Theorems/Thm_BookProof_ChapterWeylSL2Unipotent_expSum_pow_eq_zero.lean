-- Generated from ChapterWeylSL2Unipotent.lean — theorem BookProof.ChapterWeylSL2Unipotent.expSum_pow_eq_zero
import Definitions.Def_ChapterWeylSl2
import Definitions.Def_ChapterWeylSL2Group
import Mathlib
import Definitions.Def_ChapterWeylSL2Unipotent
open BookProof.ChapterWeylSL2Unipotent



open BookProof.ChapterWeylSl2 BookProof.ChapterWeylSL2Group
open Polynomial

universe u

variable {M : Type*} [AddCommGroup M] [Module ℂ M]
variable {V : Type u} [AddCommGroup V] [Module ℂ V]

theorem BookProof.ChapterWeylSL2Unipotent.expSum_pow_eq_zero {A : Module.End ℂ V} {N m : ℕ} (hnil : A ^ N = 0) (hNm : N ≤ m) :
    A ^ m = 0 := by sorry
