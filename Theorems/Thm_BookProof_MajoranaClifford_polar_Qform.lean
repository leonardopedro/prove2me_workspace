-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.polar_Qform
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford









open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

theorem BookProof.MajoranaClifford.polar_Qform (v w : V) : polar (Qform (V := V)) v w = 2 * ⟪v, w⟫ := by sorry
