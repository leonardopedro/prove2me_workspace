-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.car
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
import Theorems.Thm_BookProof_MajoranaClifford_polar_Qform
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution (v w : V) :
    a v * a w + a w * a v
      = algebraMap ℝ (CliffordAlgebra (Qform (V := V))) (2 * ⟪v, w⟫) := by

  rw [a, a, ι_mul_ι_add_swap, polar_Qform]
