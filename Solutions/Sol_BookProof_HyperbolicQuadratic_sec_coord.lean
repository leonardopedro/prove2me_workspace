-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.sec_coord
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (x : Vd d) (t : ℝ) : (sec i x t) i = t := by

  simp [sec_apply]
