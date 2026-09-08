-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussInt_sum
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_add
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) (f : ι → MvPolynomial (Fin d) ℂ) :
    gaussInt (∑ v ∈ s, f v) = ∑ v ∈ s, gaussInt (f v) := by

  classical
  induction s using Finset.induction with
  | empty => simp [gaussInt]
  | insert v s hv ih =>
      rw [Finset.sum_insert hv, Finset.sum_insert hv, gaussInt_add, ih]
