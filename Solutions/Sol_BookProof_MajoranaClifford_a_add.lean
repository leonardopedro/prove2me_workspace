-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.a_add
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution (v w : V) : a (v + w) = a v + a w := by

  simp [a, map_add]
