-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.mulOp_eq_mulXPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) :
    mulOp (X i : MvPolynomial (Fin d) ℂ) = mulXPoly i := by

  refine LinearMap.ext fun p => ?_
  simp [mulOp, mulXPoly]
