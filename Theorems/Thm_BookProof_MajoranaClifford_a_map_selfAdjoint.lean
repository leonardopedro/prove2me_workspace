-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.a_map_selfAdjoint
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford









open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

theorem BookProof.MajoranaClifford.a_map_selfAdjoint (T : V →ₗ[ℝ] V) (v : V) : reverse (a (T v)) = a (T v) := by sorry
