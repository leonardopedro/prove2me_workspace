-- Generated from ChapterFreeFieldBornSignAction.lean — solution of BookProof.ChapterFreeFieldBornSignAction.boolFlip_eq_self_iff
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignAction



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {b : Fin n → Bool} {x : EuclideanSpace ℝ (Fin n)} :
    boolFlip b x = x ↔ ∀ k, x k ≠ 0 → b k = false := by

  refine ⟨fun h => ?_, fun h => ?_⟩
  · intro k hk
    cases hb : b k
    · rfl
    · have hval : (if b k then -1 else 1) * x k = x k := by
        rw [← boolFlip_apply]
        exact congrArg (fun y : EuclideanSpace ℝ (Fin n) => y k) h
      simp [hb] at hval
      have hk2 : x k ≠ 0 := by simpa using hk
      have : x k = 0 := by linarith
      exact absurd this hk2
  · ext k; by_cases hk : x.ofLp k = 0 <;> simp_all [boolFlip_apply]
