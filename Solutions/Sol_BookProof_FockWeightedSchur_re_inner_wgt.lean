-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.re_inner_wgt
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wgt_apply
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (wgt w u)) : ℂ).re = ∑ α ∈ u.support, wSym w α * ‖u α‖ ^ 2 := by

  classical
  rw [inner_toLp u (wgt w u)]
  have hterm : ∀ α : Conf, (starRingEnd ℂ) (u α) * (wgt w u) α
      = ((wSym w α * ‖u α‖ ^ 2 : ℝ) : ℂ) := by
    intro α
    rw [wgt_apply]
    have : (starRingEnd ℂ) (u α) * u α = ((‖u α‖ ^ 2 : ℝ) : ℂ) := by
      rw [← Complex.normSq_eq_conj_mul_self, Complex.normSq_eq_norm_sq]
    push_cast
    rw [show (starRingEnd ℂ) (u α) * ((wSym w α : ℂ) * u α)
        = (wSym w α : ℂ) * ((starRingEnd ℂ) (u α) * u α) from by ring, this]
    push_cast
    ring
  rw [Finset.sum_congr rfl (fun α _ => hterm α), ← Complex.ofReal_sum, Complex.ofReal_re]
