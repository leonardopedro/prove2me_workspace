-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.momPoly_eq_ymMomOp
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
theorem solution (i : Fin d) :
    momPoly i = BookProof.YangMillsHermite.momOp i := by

  refine LinearMap.ext fun p => ?_
  rw [momPoly_apply, BookProof.YangMillsHermite.momOp_apply]
  rw [MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul]
  push_cast
  ring
