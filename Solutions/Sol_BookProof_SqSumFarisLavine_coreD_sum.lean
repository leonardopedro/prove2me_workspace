-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.coreD_sum
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) (j : Fin D) (f : ι → MvPolynomial (Fin D) ℂ) :
    coreD j (∑ i ∈ s, f i) = ∑ i ∈ s, coreD j (f i) := by

  classical
  induction s using Finset.induction_on with
  | empty => simp [coreD]
  | insert a s ha ih => rw [Finset.sum_insert ha, coreD_add, ih, Finset.sum_insert ha]
