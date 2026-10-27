-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.norm_dcommOp_le
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmDiracYukawa_dcommOp_apply
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}
variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {H N : FermiFock n →ₗ[ℂ] FermiFock n} {K Om : ℝ}
    (hK : ∀ ψ, ‖H ψ‖ ≤ K * ‖ψ‖) (hN : ∀ ψ, ‖N ψ‖ ≤ Om * ‖ψ‖) (hKn : 0 ≤ K) (hOn : 0 ≤ Om)
    (ψ : FermiFock n) : ‖dcommOp H N ψ‖ ≤ 4 * K * Om ^ 2 * ‖ψ‖ := by

  have hHψ : ‖H ψ‖ ≤ K * ‖ψ‖ := hK ψ
  have hNψ : ‖N ψ‖ ≤ Om * ‖ψ‖ := hN ψ
  have hNH : ‖N (H ψ)‖ ≤ Om * (K * ‖ψ‖) :=
    (hN (H ψ)).trans (mul_le_mul_of_nonneg_left hHψ hOn)
  have h1 : ‖N (N (H ψ))‖ ≤ Om * (Om * (K * ‖ψ‖)) :=
    (hN _).trans (mul_le_mul_of_nonneg_left hNH hOn)
  have hHN : ‖H (N ψ)‖ ≤ K * (Om * ‖ψ‖) :=
    (hK _).trans (mul_le_mul_of_nonneg_left hNψ hKn)
  have h2 : ‖N (H (N ψ))‖ ≤ Om * (K * (Om * ‖ψ‖)) :=
    (hN _).trans (mul_le_mul_of_nonneg_left hHN hOn)
  have hNN : ‖N (N ψ)‖ ≤ Om * (Om * ‖ψ‖) :=
    (hN _).trans (mul_le_mul_of_nonneg_left hNψ hOn)
  have h3 : ‖H (N (N ψ))‖ ≤ K * (Om * (Om * ‖ψ‖)) :=
    (hK _).trans (mul_le_mul_of_nonneg_left hNN hKn)
  rw [dcommOp_apply]
  have hsum : ‖N (N (H ψ)) - N (H (N ψ)) - (N (H (N ψ)) - H (N (N ψ)))‖
      ≤ ‖N (N (H ψ))‖ + ‖N (H (N ψ))‖ + (‖N (H (N ψ))‖ + ‖H (N (N ψ))‖) :=
    le_trans (norm_sub_le _ _) (add_le_add (norm_sub_le _ _) (norm_sub_le _ _))
  have hfin : ‖N (N (H ψ))‖ + ‖N (H (N ψ))‖ + (‖N (H (N ψ))‖ + ‖H (N (N ψ))‖)
      ≤ 4 * K * Om ^ 2 * ‖ψ‖ := by nlinarith
  linarith
