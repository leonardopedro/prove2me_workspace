-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.isShiftInvertC_neg_resCLM
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_resCLM_mem
import Theorems.Thm_BookProof_FriedrichsSquare_IsFriedrichsSqExtension_symmetric
import Theorems.Thm_BookProof_HashimotoShiftInvert_isShiftInvertC_of_rightInverse
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint F) :
    IsShiftInvertC T.op Complex.I (-(T.resCLM 1)) := by

  have hI : (Complex.I).im ≠ 0 := by simp
  have key : ∀ x : T.domain, cshiftMap T.op Complex.I x = -(T.shift 1 x) := by
    intro x
    rw [UnboundedSelfAdjoint.shift_apply]
    change Complex.I • (x : F) - T.op x = -(T.op x - (((1 : ℝ) : ℂ) * Complex.I) • (x : F))
    simp only [Complex.ofReal_one, one_mul]
    abel
  refine isShiftInvertC_of_rightInverse T.symmetric hI fun u => ?_
  have hmem : (-(T.resCLM 1)) u ∈ T.domain := by
    have h := T.resCLM_mem 1 u
    simp only [ContinuousLinearMap.neg_apply]
    exact T.domain.neg_mem h
  refine ⟨hmem, ?_⟩
  have hneg : (⟨(-(T.resCLM 1)) u, hmem⟩ : T.domain) = -(T.res 1 u) := Subtype.ext (by simp)
  rw [hneg, map_neg, key, neg_neg, T.shift_res one_ne_zero]
