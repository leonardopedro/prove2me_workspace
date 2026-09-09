-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.a_sq
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
import Theorems.Thm_BookProof_MajoranaClifford_Qform_apply
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution (v : V) : a v * a v = algebraMap ℝ (CliffordAlgebra (Qform (V := V))) ⟪v, v⟫ := by

  rw [a, ι_sq_scalar]
  rw [Qform_apply]
