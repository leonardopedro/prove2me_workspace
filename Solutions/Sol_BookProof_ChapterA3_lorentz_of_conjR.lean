-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.lorentz_of_conjR
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_toC_mgammaR
import Theorems.Thm_BookProof_ChapterA3_lorentz_of_conj
import Theorems.Thm_BookProof_ChapterA3_toC_det
import Theorems.Thm_BookProof_ChapterA3_toC_inv
import Theorems.Thm_BookProof_ChapterA3_toC_mul
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (S : Matrix (Fin 4) (Fin 4) ℝ) (hS : IsUnit S.det)
    (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : HasLambda S Λ) :
    Λ * minkowskiMat * Λᵀ = minkowskiMat := by

  convert lorentz_of_conj ( toC S ) _ Λ _ using 1;
  · rw [ toC_det ];
    exact IsUnit.map ( algebraMap ℝ ℂ ) hS;
  · intro μ; specialize hΛ μ; simp_all only [isUnit_iff_ne_zero, ne_eq, ← toC_inv, Complex.coe_smul]
      ;
    convert congr_arg ( fun x : Matrix ( Fin 4 ) ( Fin 4 ) ℝ => toC x ) hΛ using 1;
    · simp [ toC_mul, toC_inv, toC_mgammaR ];
    · ext i j; simp [ toC, mgammaR ] ;
      simp [ Matrix.sum_apply, mgamma ]
