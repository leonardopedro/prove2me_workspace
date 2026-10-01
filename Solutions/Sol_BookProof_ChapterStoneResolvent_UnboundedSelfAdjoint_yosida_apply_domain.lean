-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.yosida_apply_domain
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_eq_op
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_jn_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_op
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℝ} (hn : n ≠ 0) (x : T.domain) :
    T.yosida n (x : H) = T.jn n (T.op x) := by

  rw [T.yosida_eq_op hn, jn_apply]
  congr 1
  have h1 : ((T.res n (T.resCLM (-n) (x : H)) : T.domain) : H)
      = ((T.res n ((T.res (-n) (x : H) : T.domain) : H) : T.domain) : H) := rfl
  have hn' : -n ≠ 0 := neg_ne_zero.mpr hn
  have e1 : ((T.res (-n) (T.op x) : T.domain) : H) = T.op (T.res (-n) (x : H)) := T.res_op hn' x
  have e2 : ((T.res n (T.op (T.res (-n) (x : H))) : T.domain) : H)
      = T.op (T.res n ((T.res (-n) (x : H) : T.domain) : H)) := T.res_op hn _
  simp only [resCLM_apply]
  rw [← e2, ← e1]
