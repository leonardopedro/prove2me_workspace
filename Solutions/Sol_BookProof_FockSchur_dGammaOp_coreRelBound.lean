-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.dGammaOp_coreRelBound
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_normSq_toLp_of_subset
import Theorems.Thm_BookProof_FockSchur_norm_dGamma_le
import Theorems.Thm_BookProof_FockSchur_numWeight_apply
import Theorems.Thm_BookProof_FockSchur_diagMax_numSym_eq
import Theorems.Thm_BookProof_FockSecondQuantization_coe_dGammaOp
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hK : SchurBound col K) (hherm : IsHermCol col) (hK0 : 0 ≤ K) :
    CoreRelBound numSym (dGammaOp col) K := by

  classical
  intro x
  set u : FockAlg := fockEquiv.symm x with hu
  have h1 : (dGammaOp col x : Fock) = toLp (dGamma col u) := coe_dGammaOp col x
  have h2 : (diagMax numSym (inclC numSym x) : Fock) = toLp (numWeight u) :=
    diagMax_numSym_eq x
  have hsupp : (numWeight u).support ⊆ u.support := Finsupp.support_onFinset_subset
  have hN : ‖toLp (numWeight u)‖ ^ 2 = ∑ α ∈ u.support, (numSym α) ^ 2 * ‖u α‖ ^ 2 := by
    rw [normSq_toLp_of_subset hsupp]
    refine Finset.sum_congr rfl fun α _ => ?_
    rw [numWeight_apply, norm_mul, mul_pow, Complex.norm_real, Real.norm_eq_abs,
      sq_abs]
  have hmono : ∑ α ∈ u.support, ((ndeg α : ℝ)) ^ 2 * ‖u α‖ ^ 2
      ≤ ∑ α ∈ u.support, (numSym α) ^ 2 * ‖u α‖ ^ 2 := by
    refine Finset.sum_le_sum fun α _ => ?_
    have h0 : (0:ℝ) ≤ (ndeg α : ℝ) := Nat.cast_nonneg _
    have hle : (ndeg α : ℝ) ≤ numSym α := by simp only [numSym]; linarith
    have hsq : ((ndeg α : ℝ)) ^ 2 ≤ (numSym α) ^ 2 := by nlinarith [h0, hle]
    exact mul_le_mul_of_nonneg_right hsq (sq_nonneg ‖u α‖)
  have hbound := norm_dGamma_le hK hherm hK0 u
  have hsq : ‖toLp (dGamma col u)‖ ^ 2 ≤ (K * ‖toLp (numWeight u)‖) ^ 2 := by
    rw [mul_pow, hN]
    refine le_trans hbound ?_
    exact mul_le_mul_of_nonneg_left hmono (sq_nonneg K)
  have hR : 0 ≤ K * ‖toLp (numWeight u)‖ := mul_nonneg hK0 (norm_nonneg _)
  have hL : 0 ≤ ‖toLp (dGamma col u)‖ := norm_nonneg _
  rw [h1, h2]
  nlinarith [hsq, hR, hL]
