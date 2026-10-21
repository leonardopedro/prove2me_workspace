-- Generated from ChapterSchurIrreducible.lean — solution of BookProof.ChapterSchurIrreducible.commutant_eq_scalars_of_irreducible
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Theorems.Thm_BookProof_ChapterSchurIrreducible_isSchurFull_of_irreducible
import Theorems.Thm_BookProof_ChapterA_commutant_eq_complex_scalars
open BookProof.ChapterSchurIrreducible



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) (hM : M.IsNormal)
    (hirr : M.IsIrreducible) (S : V →L[ℂ] V) :
    M.Commutes S ↔ ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) := commutant_eq_complex_scalars M (isSchurFull_of_irreducible M hM hirr) S
