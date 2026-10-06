-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.hasLambda_unique
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_mgammaR_indep
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution {S Λ Λ' : Matrix (Fin 4) (Fin 4) ℝ}
    (h : HasLambda S Λ) (h' : HasLambda S Λ') : Λ = Λ' := by

  ext μ ν; have := h μ; have := h' μ; simp_all only [HasLambda, implies_true] ;
  have h_eq : ∀ μ, ∑ ν, (Λ μ ν - Λ' μ ν) • mgammaR ν = 0 := by
    simp_all [ sub_smul, Finset.sum_sub_distrib ];
  exact sub_eq_zero.mp ( mgammaR_indep _ ( h_eq μ ) ν )
