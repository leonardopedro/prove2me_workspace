-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.volumePoly_not_quadratic
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Theorems.Thm_BookProof_NsFullLagrangian_detPoly_eval_testPt
open BookProof.NsFullLagrangian




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin n) :
    ¬ ∃ a b c : ℂ, ∀ t : ℝ,
        eval (testPt p t) (volumePoly p) = a * (t : ℂ) ^ 2 + b * (t : ℂ) + c := by

  rintro ⟨a, b, c, h⟩
  have key : ∀ t : ℝ, eval (testPt p t) (volumePoly p) = (t : ℂ) ^ 3 - 1 := by
    intro t
    rw [volumePoly, map_add, detPoly_eval_testPt, eval_C]
    push_cast
    ring
  have h0 := h 0
  have h1 := h 1
  have h2 := h 2
  have h3 := h 3
  rw [key] at h0 h1 h2 h3
  push_cast at h0 h1 h2 h3
  have hc : c = -1 := by linear_combination -h0
  have hab : a + b = 1 := by linear_combination h0 - h1
  have hab2 : 4 * a + 2 * b = 8 := by linear_combination h0 - h2
  have hab3 : 9 * a + 3 * b = 27 := by linear_combination h0 - h3
  have ha : a = 3 := by linear_combination (hab2 - 2 * hab) / 2
  have hb : b = -2 := by linear_combination hab - ha
  rw [ha, hb] at hab3
  norm_num at hab3
