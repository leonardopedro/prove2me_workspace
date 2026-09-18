-- Generated from ChapterQgHermiteOscillatorEsa.lean — solution of BookProof.QgHermiteOscillator.potLp_harmW
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_QgHermiteOscillator_eval_harmPoly
import Theorems.Thm_BookProof_QgHermiteCore_memLp_mul_pgFun_of_expBounded
open BookProof.QgHermiteOscillator




open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin d) ℂ) :
    potLp harmW continuous_harmW expBounded_harmW p = pgLp (harmPoly * p) := by

  unfold potLp pgLp
  refine MemLp.toLp_congr _ _ ?_
  filter_upwards with x
  simp only [pgFun, map_mul, eval_harmPoly]
  ring
