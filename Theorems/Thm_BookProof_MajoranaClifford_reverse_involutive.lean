-- Generated from ChapterMajoranaClifford.lean — theorem BookProof.MajoranaClifford.reverse_involutive
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford









open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

theorem BookProof.MajoranaClifford.reverse_involutive :
    Function.Involutive (reverse : CliffordAlgebra (Qform (V := V)) → _) := by sorry
