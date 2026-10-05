-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.sqrtRel_comp_self
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_mem_sqrtRel_iff
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtB_sqrtB_apply
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtC_sqrtC_apply
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtB_sqrtC_apply
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_of_mem
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) :
    {p : F × F | ∃ w, (p.1, w) ∈ sqrtRel hT ∧ (w, p.2) ∈ sqrtRel hT} = (T : Set (F × F)) := by

  ext p
  obtain ⟨x, z⟩ := p
  constructor
  · rintro ⟨w, hw1, hw2⟩
    obtain ⟨y, hy1, hy2⟩ := mem_sqrtRel_iff.1 hw1
    obtain ⟨y', hy1', hy2'⟩ := mem_sqrtRel_iff.1 hw2
    simp only at hy1 hy2 hy1' hy2'
    have hCC : sqrtC hT (sqrtC hT y) = sqrtB hT z := by
      rw [hy2, ← hy1', ← sqrtB_sqrtC_apply, hy2']
    have hy : y = sqrtB hT (sqrtB hT y + z) := by
      have h1 : sqrtB hT (sqrtB hT y) + sqrtC hT (sqrtC hT y) = y := by
        rw [sqrtB_sqrtB_apply, sqrtC_sqrtC_apply]; abel
      rw [map_add, ← hCC, h1]
    have hx : x = invCLM hT (sqrtB hT y + z) := by
      rw [← hy1]
      conv_lhs => rw [hy]
      rw [sqrtB_sqrtB_apply]
    have hsum : sqrtB hT y + z - x = z := by rw [← hy1]; abel
    have hmem := invCLM_mem hT (sqrtB hT y + z)
    rw [← hx, hsum] at hmem
    exact hmem
  · intro hp
    have hRx : invCLM hT (x + z) = x :=
      invCLM_eq_of_mem hT (by simpa using hp)
    refine ⟨sqrtC hT (sqrtB hT (x + z)), ?_, ?_⟩
    · refine mem_sqrtRel_iff.2 ⟨sqrtB hT (x + z), ?_, rfl⟩
      rw [sqrtB_sqrtB_apply, hRx]
    · refine mem_sqrtRel_iff.2 ⟨sqrtC hT (x + z), ?_, ?_⟩
      · exact (sqrtB_sqrtC_apply hT (x + z)).symm ▸ rfl
      · have h1 : sqrtC hT (sqrtC hT (x + z)) = (x + z) - invCLM hT (x + z) :=
          sqrtC_sqrtC_apply hT (x + z)
        rw [h1, hRx]
        abel
