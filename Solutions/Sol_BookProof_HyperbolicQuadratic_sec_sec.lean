-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.sec_sec
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (x : Vd d) (t s : ℝ) : sec i (sec i x t) s = sec i x s := by

  ext j
  rcases eq_or_ne j i with h | h
  · simp [sec_apply, h]
  · simp [sec_apply, h]
