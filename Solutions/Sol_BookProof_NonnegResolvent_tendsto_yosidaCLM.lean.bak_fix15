-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.tendsto_yosidaCLM
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_tendsto_smul_invCLMAt
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_of_mem
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) {ε : ℝ} (hε : 0 < ε) :
    ∃ A : ℝ, 0 < A ∧ ∀ (c : ℝ) (hc : 0 < c), A ≤ c → ‖yosidaCLM hT hc h - k‖ < ε := by

  obtain ⟨A, hA, hbound⟩ := tendsto_smul_invCLMAt hT hsv k hε
  refine ⟨A, hA, ?_⟩
  intro c hc hcA
  rw [yosidaCLM_of_mem hT hc hk]
  exact hbound c hc hcA
