-- Generated from ChapterSchurIrreducible.lean — solution of BookProof.ChapterSchurIrreducible.rangeClosure_invariant
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Theorems.Thm_BookProof_ChapterSchurIrreducible_isClosed_rangeClosure
open BookProof.ChapterSchurIrreducible



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {F m : V →L[ℂ] V} (hc : Commute F m) {w : V}
    (hw : w ∈ rangeClosure F) : m w ∈ rangeClosure F := by

  have hle : (LinearMap.range (F : V →ₗ[ℂ] V)) ≤
      Submodule.comap (m : V →ₗ[ℂ] V) (rangeClosure F) := by
    rintro _ ⟨x, rfl⟩
    refine Submodule.le_topologicalClosure _ ?_
    exact ⟨m x, by
      have := congrArg (fun T : V →L[ℂ] V => T x) hc
      simpa [ContinuousLinearMap.mul_apply] using this⟩
  have hclosed : IsClosed
      ((Submodule.comap (m : V →ₗ[ℂ] V) (rangeClosure F) : Submodule ℂ V) : Set V) :=
    IsClosed.preimage m.continuous (isClosed_rangeClosure F)
  exact Submodule.topologicalClosure_minimal _ hle hclosed hw
