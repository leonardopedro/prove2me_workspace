-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.reverse_involutive
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution :
    Function.Involutive (reverse : CliffordAlgebra (Qform (V := V)) → _) := fun x => reverse_reverse x
