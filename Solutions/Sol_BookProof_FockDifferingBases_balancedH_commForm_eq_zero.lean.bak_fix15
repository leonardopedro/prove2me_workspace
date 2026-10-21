-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.balancedH_commForm_eq_zero
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockDifferingBases_pairOp_commForm_eq_zero
import Theorems.Thm_BookProof_FockQuadratic_freeOp_commForm
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_quadForm_nonneg
import Theorems.Thm_BookProof_OperatorSeries_commForm_add
import Theorems.Thm_BookProof_OperatorSeries_seriesOp_commForm_le
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) (hsum : Summable fun k => ‖g k‖)
    (hbal : ∀ k, Balanced ω (P k) (Q k)) (x : maxDom (sig ω)) :
    commForm (balancedH hω P Q g hPQ hsum) (diagMax (sig ω)) x = 0 := by

  have hc0 : ∀ b : Idx ι, 0 ≤ sig ω b := fun b => sig_nonneg hω b
  have hsplit := commForm_add (freeOp hω)
    (seriesOp (couplingT hω P Q g hPQ) (fun k => 4 * ‖g k‖)
      (couplingT_norm_le hω P Q g hPQ) (hsum.mul_left 4)) (diagMax (sig ω)) x
  have hfree := freeOp_commForm hω x
  have hser := seriesOp_commForm_le (couplingT_norm_le hω P Q g hPQ) (hsum.mul_left 4)
    (b := fun _ : κ => (0 : ℝ)) summable_zero
    (fun k y => by
      rw [couplingT, pairOp_commForm_eq_zero hω (g k) (P k) (Q k) (hPQ k) (hbal k) y]
      simp)
    (fun y => diagMax_quadForm_nonneg (sig ω) hc0 y) x
  simp only [tsum_zero, zero_mul, abs_nonpos_iff] at hser
  have : commForm (balancedH hω P Q g hPQ hsum) (diagMax (sig ω)) x
      = commForm (freeOp hω) (diagMax (sig ω)) x
        + commForm (seriesOp (couplingT hω P Q g hPQ) (fun k => 4 * ‖g k‖)
            (couplingT_norm_le hω P Q g hPQ) (hsum.mul_left 4)) (diagMax (sig ω)) x := hsplit
  rw [this, hfree, hser, add_zero]
