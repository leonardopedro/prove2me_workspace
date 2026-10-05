-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsResPoly_eval_testPt
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_NsFullEuler_ycoord_injective
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
theorem solution (nu : ℝ) (p : Fin n) (t : ℝ) :
    eval (testPt p t) (nsResPoly nu p 0) = (t : ℂ) * (t : ℂ) := by

  have hne : ∀ i j : Fin 21, i ≠ j → ycoord p i ≠ ycoord p j := fun i j hij h =>
    hij (ycoord_injective p h)
  have h1 : ycoord p (uIdx 0) ≠ ycoord p (uIdx 1) := hne _ _ (by decide)
  have h2 : ycoord p (uIdx 0) ≠ ycoord p (dIdx 0 1) := hne _ _ (by decide)
  have h3 : ycoord p (uIdx 2) ≠ ycoord p (uIdx 1) := hne _ _ (by decide)
  have h4 : ycoord p (uIdx 2) ≠ ycoord p (dIdx 0 1) := hne _ _ (by decide)
  have h5 : ycoord p (dIdx 0 0) ≠ ycoord p (uIdx 1) := hne _ _ (by decide)
  have h6 : ycoord p (dIdx 0 0) ≠ ycoord p (dIdx 0 1) := hne _ _ (by decide)
  have h7 : ycoord p (dIdx 0 2) ≠ ycoord p (uIdx 1) := hne _ _ (by decide)
  have h8 : ycoord p (dIdx 0 2) ≠ ycoord p (dIdx 0 1) := hne _ _ (by decide)
  have h9 : ycoord p (qIdx 0) ≠ ycoord p (uIdx 1) := hne _ _ (by decide)
  have h10 : ycoord p (qIdx 0) ≠ ycoord p (dIdx 0 1) := hne _ _ (by decide)
  have h11 : ycoord p (wIdx 0) ≠ ycoord p (uIdx 1) := hne _ _ (by decide)
  have h12 : ycoord p (wIdx 0) ≠ ycoord p (dIdx 0 1) := hne _ _ (by decide)
  simp [nsResPoly, testPt, Fin.sum_univ_three, h1, h2, h3, h4, h5,
    h6, h7, h8, h9, h10, h11, h12]
