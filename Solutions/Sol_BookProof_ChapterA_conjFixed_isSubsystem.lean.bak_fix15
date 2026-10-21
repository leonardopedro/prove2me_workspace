-- Generated from ChapterA1f.lean — solution of BookProof.ChapterA.conjFixed_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1f
import Theorems.Thm_BookProof_ChapterA_conjFixed_isClosed
import Theorems.Thm_BookProof_ChapterA_conjFixed_invariant
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) (θ : AntiUnitary V) (hθ : IsConjugation M θ) :
    (rxSystem M).IsSubsystem (conjFixed θ) := ⟨conjFixed_isClosed θ, conjFixed_invariant M θ hθ⟩
