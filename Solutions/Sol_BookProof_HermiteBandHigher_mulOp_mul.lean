-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.mulOp_mul
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
theorem solution (f g : MvPolynomial (Fin d) ℂ) :
    mulOp (f * g) = (mulOp f) ∘ₗ (mulOp g) := by

  refine LinearMap.ext fun p => ?_
  simp [mulOp]
