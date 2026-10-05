-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.LadderOrd.sum
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_ladderOrd_zero
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_add
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι)
    {T : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {n : ℕ}
    (h : ∀ i ∈ s, LadderOrd (T i) n) : LadderOrd (∑ i ∈ s, T i) n := by

  classical
  induction s using Finset.induction with
  | empty => simpa using ladderOrd_zero n
  | insert i s hi ih =>
      rw [Finset.sum_insert hi]
      exact (h i (Finset.mem_insert_self i s)).add
        (ih fun j hj => h j (Finset.mem_insert_of_mem hj))
