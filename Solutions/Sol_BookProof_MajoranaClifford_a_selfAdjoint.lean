-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.a_selfAdjoint
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution (v : V) : reverse (a v) = a v := by

  rw [a, reverse_ι]
