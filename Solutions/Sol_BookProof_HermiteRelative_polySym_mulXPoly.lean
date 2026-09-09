-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.polySym_mulXPoly
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_mulXPoly_eq_mulOp
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
theorem solution (i : Fin d) : BookProof.YangMillsHermite.PolySym (mulXPoly i) := by

  rw [mulXPoly_eq_mulOp]
  exact BookProof.YangMillsHermite.mulOp_polySym (BookProof.YangMillsHermite.realCoeff_X i)
