-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.a_sq
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford









open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

theorem BookProof.MajoranaClifford.a_sq (v : V) : a v * a v = algebraMap ℝ (CliffordAlgebra (Qform (V := V))) ⟪v, v⟫ := by sorry
