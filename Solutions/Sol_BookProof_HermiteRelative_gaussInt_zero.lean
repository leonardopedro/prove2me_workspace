-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.gaussInt_zero
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative










open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}





variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : gaussInt (0 : MvPolynomial (Fin d) ℂ) = 0 := by

  have h := gaussInt_smul (0 : ℂ) (0 : MvPolynomial (Fin d) ℂ)
  simpa using h
