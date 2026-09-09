-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.res_sub_res
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
open BookProof.SirkSingleTime








open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.SirkSingleTime.res_sub_res (T : UnboundedSelfAdjoint E) {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0) (y : E) :
    ((T.res l y : T.domain) : E) - ((T.res m y : T.domain) : E)
      = (((l - m : ℝ) : ℂ) * Complex.I) •
          ((T.res l ((T.res m y : T.domain) : E) : T.domain) : E) := by sorry
