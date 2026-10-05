-- Generated from ChapterF8.lean — solution of BookProof.ChapterF8.offline_operatorBasis
import Mathlib
import Definitions.Def_ChapterF8
open BookProof.ChapterF8



noncomputable section

open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) :
    Submodule.span ℂ (operatorBasis m) = ⊤ := by

  refine Submodule.eq_top_iff'.mpr fun A => ?_
  rw [Matrix.matrix_eq_sum_single A]
  refine Submodule.sum_mem _ fun i _ => Submodule.sum_mem _ fun j _ => ?_
  have hscale : Matrix.single i j (A i j) = A i j • Matrix.single i j (1 : ℂ) := by
    ext a b
    by_cases ha : a = i <;> by_cases hb : b = j <;>
      simp [Matrix.single, ha, hb]
  rw [hscale]
  exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨(i, j), rfl⟩)
