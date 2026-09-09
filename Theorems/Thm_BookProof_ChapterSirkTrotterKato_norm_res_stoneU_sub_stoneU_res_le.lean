-- Generated from ChapterSirkTrotterKato.lean — theorem BookProof.ChapterSirkTrotterKato.norm_res_stoneU_sub_stoneU_res_le
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato










noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.norm_res_stoneU_sub_stoneU_res_le (T S : UnboundedSelfAdjoint H) (chi : T.domain)
    (t : ℝ) {C : ℝ}
    (hC : ∀ s ∈ Set.uIcc (0 : ℝ) t,
      ‖T.resCLM 1 (T.stoneU s (T.shift 1 chi)) - S.resCLM 1 (T.stoneU s (T.shift 1 chi))‖ ≤ C) :
    ‖S.resCLM 1 (T.stoneU t (chi : H)) - S.stoneU t (S.resCLM 1 (chi : H))‖ ≤ C * |t| := by sorry
