-- Generated from ChapterSchurIrreducible.lean — solution of BookProof.ChapterSchurIrreducible.rangeClosure_le_ker
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {F G : V →L[ℂ] V} (h : G * F = 0) :
    rangeClosure F ≤ LinearMap.ker (G : V →ₗ[ℂ] V) := by

  refine Submodule.topologicalClosure_minimal _ ?_ ?_
  · rintro _ ⟨x, rfl⟩
    have := congrArg (fun T : V →L[ℂ] V => T x) h
    simpa [ContinuousLinearMap.mul_apply] using this
  · exact (ContinuousLinearMap.isClosed_ker G).preimage continuous_id
