-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.isBandDeg_mulOp
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_le
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandDeg_le
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_sum
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandDeg_sum
import Theorems.Thm_BookProof_HermiteBandHigher_mulOp_sum
import Theorems.Thm_BookProof_HermiteBandHigher_isBandDeg_mulOp_monomial
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin d) ℂ) :
    IsBandDeg p.totalDegree (mulOp p) :=
  .totalDegree (mulOp p) := by
    classical
    have hp : p = ∑ s ∈ p.support, (monomial s (coeff s p) : MvPolynomial (Fin d) ℂ) :=
      (MvPolynomial.support_sum_monomial_coeff p).symm
    rw [show mulOp p = ∑ s ∈ p.support, mulOp (monomial s (coeff s p)) by
      conv_lhs => rw [hp]
      rw [mulOp_sum]]
    refine IsBandDeg.sum _ _ fun s hs => ?_
    refine IsBandDeg.le ?_ (isBandDeg_mulOp_monomial s (coeff s p))
    exact MvPolyn
