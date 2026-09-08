-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.a_smul
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution (c : ℝ) (v : V) : a (c • v) = c • a v := by

  simp [a, map_smul]
