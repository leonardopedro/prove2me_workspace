-- Generated from ChapterSirkSingleTimeShift.lean — solution of BookProof.SirkSingleTime.isShiftInvertC_neg_resCLM_shift
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore









open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint E) {l : ℝ} (hl : l ≠ 0) :
    IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) := by

  have hI : ((((l : ℝ) : ℂ) * Complex.I)).im ≠ 0 := by simpa using hl
  have key : ∀ x : T.domain,
      cshiftMap T.op (((l : ℝ) : ℂ) * Complex.I) x = -(T.shift l x) := by
    intro x
    rw [UnboundedSelfAdjoint.shift_apply, cshiftMap_apply]
    abel
  refine isShiftInvertC_of_rightInverse T.symmetric hI fun u => ?_
  have hmem : (-(T.resCLM l)) u ∈ T.domain := by
    have h := T.resCLM_mem l u
    simp only [ContinuousLinearMap.neg_apply]
    exact T.domain.neg_mem h
  refine ⟨hmem, ?_⟩
  have hneg : (⟨(-(T.resCLM l)) u, hmem⟩ : T.domain) = -(T.res l u) := Subtype.ext (by simp)
  rw [hneg, map_neg, key, neg_neg, T.shift_res hl]
