-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.mulOp_sum
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_mulOp_add'
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) (F : ι → MvPolynomial (Fin d) ℂ) :
    mulOp (∑ i ∈ s, F i) = ∑ i ∈ s, mulOp (F i) := by

  classical
  induction s using Finset.induction_on with
  | empty => refine LinearMap.ext fun p => ?_; simp [mulOp]
  | insert a s ha ih => rw [Finset.sum_insert ha, mulOp_add', ih, Finset.sum_insert ha]
