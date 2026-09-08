-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.reverse_antihom
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution (x y : CliffordAlgebra (Qform (V := V))) :
    reverse (x * y) = reverse y * reverse x := reverse.map_mul x y
