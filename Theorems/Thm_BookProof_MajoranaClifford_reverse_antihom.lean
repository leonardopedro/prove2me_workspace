-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.reverse_antihom
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford









open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

theorem BookProof.MajoranaClifford.reverse_antihom (x y : CliffordAlgebra (Qform (V := V))) :
    reverse (x * y) = reverse y * reverse x := by sorry
