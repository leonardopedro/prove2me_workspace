-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.IsBandR.sum
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_add
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandDeg_add
import Theorems.Thm_BookProof_HermiteBandHigher_isBandR_zero_op
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {r m : ℕ} {ι : Type*} (s : Finset ι)
    (F : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (h : ∀ i ∈ s, IsBandR r m (F i)) : IsBandR r m (∑ i ∈ s, F i) := by

  classical
  induction s using Finset.induction_on with
  | empty => simpa using isBandR_zero_op r m
  | insert a s ha ih =>
      rw [Finset.sum_insert ha]
      exact IsBandR.add (h a (Finset.mem_insert_self a s))
        (ih fun i hi => h i (Finset.mem_insert_of_mem hi))
