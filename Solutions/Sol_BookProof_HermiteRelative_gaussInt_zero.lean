-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.gaussInt_zero
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_smul
open BookProof.HermiteRelative




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : gaussInt (0 : MvPolynomial (Fin d) ℂ) = 0 := by

  have h := gaussInt_smul (0 : ℂ) (0 : MvPolynomial (Fin d) ℂ)
  simpa using h
