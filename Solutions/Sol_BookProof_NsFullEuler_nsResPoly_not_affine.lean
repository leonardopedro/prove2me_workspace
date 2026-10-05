-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsResPoly_not_affine
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_NsFullEuler_nsResPoly_eval_testPt
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (p : Fin n) :
    ¬ ∃ a b : ℂ, ∀ t : ℝ, eval (testPt p t) (nsResPoly nu p 0) = a * (t : ℂ) + b := by

  rintro ⟨a, b, h⟩
  have h0 := h 0
  have h1 := h 1
  have h2 := h 2
  rw [nsResPoly_eval_testPt] at h0 h1 h2
  push_cast at h0 h1 h2
  have hb : b = 0 := by linear_combination -h0
  have ha : a = 1 := by linear_combination h0 - h1
  rw [ha, hb] at h2
  norm_num at h2
