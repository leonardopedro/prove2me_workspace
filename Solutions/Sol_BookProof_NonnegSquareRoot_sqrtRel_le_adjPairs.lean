-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.sqrtRel_le_adjPairs
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_mem_sqrtRel_iff
import Theorems.Thm_BookProof_NonnegSquareRoot_isSelfAdjoint_sqrtB
import Theorems.Thm_BookProof_NonnegSquareRoot_isSelfAdjoint_sqrtC
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtB_sqrtC_apply
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) :
    sqrtRel hT ≤ adjPairs (sqrtRel hT) := by

  intro p hp q hq
  obtain ⟨y, hy1, hy2⟩ := mem_sqrtRel_iff.1 hp
  obtain ⟨z, hz1, hz2⟩ := mem_sqrtRel_iff.1 hq
  rw [← hy1, ← hy2, ← hz1, ← hz2,
    inner_isSelfAdjoint_left (isSelfAdjoint_sqrtC hT),
    inner_isSelfAdjoint_left (isSelfAdjoint_sqrtB hT), sqrtB_sqrtC_apply]
