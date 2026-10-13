-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.diagOp_normSq
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmCar_normSq_eq_sum
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.SmCar

variable {n : ℕ}

noncomputable section

variable {n : ℕ}


@[simp] private theorem diagOp_apply (d : EllInf) (f : Ell2C) (i : ℕ) :
    ((diagOp d f : Ell2C) : ℕ → ℂ) i = (d : ℕ → ℂ) i * (f : ℕ → ℂ) i := rfl

set_option maxHeartbeats 1000000 in

theorem solution (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    ‖diagOp d ψ‖ ^ 2 = ∑ S : Finset (Fin n), (d S) ^ 2 * ‖ψ S‖ ^ 2 := by
  rw [normSq_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, norm_mul, mul_pow]
  simp [Complex.norm_real, sq_abs]
