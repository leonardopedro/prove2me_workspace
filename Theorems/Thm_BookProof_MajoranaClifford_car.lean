-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.car
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford









open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

theorem BookProof.MajoranaClifford.car (v w : V) :
    a v * a w + a w * a v
      = algebraMap ℝ (CliffordAlgebra (Qform (V := V))) (2 * ⟪v, w⟫) := by sorry
