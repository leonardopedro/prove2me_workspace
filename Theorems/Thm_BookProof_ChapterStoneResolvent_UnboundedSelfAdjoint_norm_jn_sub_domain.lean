-- Generated from ChapterStoneGroup.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_jn_sub_domain
import Definitions.Def_ChapterUnitaryTransport
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport




theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_jn_sub_domain {n : ℝ} (hn : n ≠ 0) (x : T.domain) :
    ‖T.jn n (x : H) - (x : H)‖ ≤ 2 * ‖T.op x‖ / |n| := by
  have habs : 0 < |n| := abs_pos.mpr hn
  have hid : T.jn n (x : H) - (x : H)
      = -T.resCLM n (T.op x) + ((n : ℂ) * Complex.I) • T.resCLM n (T.resCLM (-n) (T.op x)) := by sorry
