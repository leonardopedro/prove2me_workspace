-- Generated from ChapterSchurFiniteDimensional.lean — solution of BookProof.ChapterSchurFiniteDimensional.Rreal_commutant_eq_real_scalars_finiteDimensional
import Mathlib
import Definitions.Def_ChapterSchurFiniteDimensional
import Theorems.Thm_BookProof_ChapterSchurFiniteDimensional_isSchurFull_of_irreducible_finiteDimensional
import Theorems.Thm_BookProof_ChapterA_Rreal_commutant_eq_real_scalars
open BookProof.ChapterSchurFiniteDimensional



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : M.IsIrreducible) {θ : AntiUnitary V} (hθ : IsConjugation M θ)
    (S : V →L[ℂ] V) :
    (M.Commutes S ∧ CommutesConj θ S) ↔ ∃ r : ℝ, S = ((r : ℂ)) • (1 : V →L[ℂ] V) :=
  Rreal_commutant_eq_real_scalars M
      (isSchurFull_of_irreducible_finiteDimensional M hirr) hθ S
