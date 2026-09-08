-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.IsBand2.sum
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Theorems.Thm_BookProof_HermiteBand_Band_add
import Theorems.Thm_BookProof_HermiteBand_IsBand1_add
import Theorems.Thm_BookProof_HermiteBand_IsBand2_add
import Theorems.Thm_BookProof_HermiteBand_isBand2_zero
open BookProof.HermiteBand
open BookProof.HermiteBand.IsBand2








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

























open BookProof.NavierStokesFlow.DifferentialL2 BookProof.FullQuadratic

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι)
    (F : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (h : ∀ i ∈ s, IsBand2 (F i)) : IsBand2 (∑ i ∈ s, F i) := by

  classical
  induction s using Finset.induction_on with
  | empty => simpa using isBand2_zero
  | insert a s ha ih =>
      rw [Finset.sum_insert ha]
      exact IsBand2.add (h a (Finset.mem_insert_self a s))
        (ih fun i hi => h i (Finset.mem_insert_of_mem hi))
