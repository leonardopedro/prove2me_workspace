-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.norm_res_neg
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
open BookProof.SirkSingleTime

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}
variable {Fin' : Type*} [NormedAddCommGroup Fin'] [InnerProductSpace ℂ Fin'] [CompleteSpace Fin']
variable {ι : Type*}


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.SirkSingleTime.norm_res_neg (T : UnboundedSelfAdjoint E) {l : ℝ} (hl : l ≠ 0) (y : E) :
    ‖((T.res (-l) y : T.domain) : E)‖ = ‖((T.res l y : T.domain) : E)‖ := by sorry
