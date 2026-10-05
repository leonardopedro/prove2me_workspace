-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.dense_domain
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) :
    Dense (T.map (LinearMap.fst ℂ F F) : Set F) := by

  refine Submodule.dense_iff_topologicalClosure_eq_top.2
    (Submodule.topologicalClosure_eq_top_iff.2 ?_)
  refine Submodule.eq_bot_iff _ |>.2 ?_
  intro z hz
  have hzero : ((0 : F), z) ∈ adjPairs T := by
    intro q hq
    have hq1 : q.1 ∈ T.map (LinearMap.fst ℂ F F) :=
      Submodule.mem_map.2 ⟨q, hq, rfl⟩
    have := (Submodule.mem_orthogonal _ _).1 hz q.1 hq1
    simpa using this.symm
  rw [hT.adj] at hzero
  exact hsv z hzero
