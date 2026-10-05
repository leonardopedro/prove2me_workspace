-- Generated from ChapterA2b.lean — solution of BookProof.ChapterA.real_scalar_commutesConj
import Mathlib
import Definitions.Def_ChapterA2b
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary V) (r : ℝ) :
    CommutesConj θ (((r : ℂ)) • (1 : V →L[ℂ] V)) := by

  intros x; exact (by
  have := θ.map_smulₛₗ ( r : ℂ ) x; simp_all  ;)
