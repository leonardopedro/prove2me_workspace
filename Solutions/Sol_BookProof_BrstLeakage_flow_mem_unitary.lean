-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.flow_mem_unitary
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {A : E →L[ℂ] E} (hA : IsSelfAdjoint A) (t : ℝ) :
    flow A t ∈ unitary (E →L[ℂ] E) := by

  have h1 : t • ((-Complex.I) • A) = Complex.I • ((-(t : ℝ)) • A) := by
    rw [smul_comm]; module
  have h2 : IsSelfAdjoint ((-(t : ℝ)) • A) := (IsSelfAdjoint.all (-(t : ℝ))).smul hA
  rw [flow, h1]
  exact (selfAdjoint.expUnitary ⟨_, h2⟩).2
