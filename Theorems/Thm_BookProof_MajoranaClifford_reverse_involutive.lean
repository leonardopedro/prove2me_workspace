-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.reverse_involutive
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]


open RealInnerProductSpace CliffordAlgebra QuadraticMap



theorem BookProof.MajoranaClifford.reverse_involutive :
    Function.Involutive (reverse : CliffordAlgebra (Qform (V := V)) → _) := by sorry
