-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.a_zero
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution : a (0 : V) = 0 := by
 simp [a]
