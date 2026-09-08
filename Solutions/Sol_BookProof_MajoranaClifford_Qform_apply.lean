-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.Qform_apply
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution (v : V) : Qform v = ⟪v, v⟫ := by

  simp [Qform, innerBilin, LinearMap.BilinMap.toQuadraticMap]
