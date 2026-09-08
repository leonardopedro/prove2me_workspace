-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.a_anticomm_of_orthogonal
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford









open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

theorem BookProof.MajoranaClifford.a_anticomm_of_orthogonal {v w : V} (h : ⟪v, w⟫ = (0 : ℝ)) :
    a v * a w + a w * a v = 0 := by sorry
