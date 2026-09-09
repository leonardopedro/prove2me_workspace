-- Generated from ChapterShiftedHermiteCore.lean — solution of BookProof.ShiftedHermiteCore.coreOpT_coe
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Theorems.Thm_BookProof_ShiftedHermiteCore_coreEquivT_coe
import Theorems.Thm_BookProof_ShiftedHermiteCore_coreOpT_coreEquivT
open BookProof.ShiftedHermiteCore











open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a k : Vd d) (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) :
    ((coreOpT a k T (coreEquivT a k p) : polyGaussCoreT a k) : L2d d) = pgLpT a k (T p) := by

  rw [coreOpT_coreEquivT, coreEquivT_coe]
