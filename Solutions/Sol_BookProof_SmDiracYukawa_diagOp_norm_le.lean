-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.diagOp_norm_le
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmDiracYukawa_diagOp_normSq
import Theorems.Thm_BookProof_SmCar_normSq_eq_sum
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {d : Finset (Fin n) → ℝ} {Om : ℝ} (hOm : 0 ≤ Om)
    (hd : ∀ S, |d S| ≤ Om) (ψ : FermiFock n) : ‖diagOp d ψ‖ ≤ Om * ‖ψ‖ := by

  have hsq : ‖diagOp d ψ‖ ^ 2 ≤ (Om * ‖ψ‖) ^ 2 := by
    rw [diagOp_normSq, mul_pow, normSq_eq_sum, Finset.mul_sum]
    refine Finset.sum_le_sum fun S _ => ?_
    have h1 : (d S) ^ 2 ≤ Om ^ 2 := by
      have := hd S
      nlinarith [abs_nonneg (d S), sq_abs (d S)]
    nlinarith [sq_nonneg ‖ψ S‖, norm_nonneg (ψ S)]
  nlinarith [norm_nonneg (diagOp d ψ), mul_nonneg hOm (norm_nonneg ψ)]
