-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.jn_apply_domain
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_jn_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_op
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℝ} (hn : n ≠ 0) (x : T.domain) :
    T.jn n (x : H) = (x : H) - T.resCLM n (T.op x)
      + ((n : ℂ) * Complex.I) • T.resCLM n (T.resCLM (-n) (T.op x)) := by

  have hn' : -n ≠ 0 := neg_ne_zero.mpr hn
  have E1 : T.resCLM (-n) (T.op x) = (x : H) - ((n : ℂ) * Complex.I) • T.resCLM (-n) (x : H) := by
    have h1 : ((T.res (-n) (T.op x) : T.domain) : H) = T.op (T.res (-n) (x : H)) :=
      T.res_op hn' x
    have h2 : T.op (T.res (-n) (x : H))
        = (x : H) + (((-n : ℝ) : ℂ) * Complex.I) • ((T.res (-n) (x : H) : T.domain) : H) :=
      T.op_res hn' (x : H)
    have := h1.trans h2
    simp only [resCLM_apply]
    rw [this]
    push_cast
    module
  have E2 : T.resCLM n (T.op x) = (x : H) + ((n : ℂ) * Complex.I) • T.resCLM n (x : H) := by
    have h1 : ((T.res n (T.op x) : T.domain) : H) = T.op (T.res n (x : H)) := T.res_op hn x
    have h2 : T.op (T.res n (x : H))
        = (x : H) + ((n : ℂ) * Complex.I) • ((T.res n (x : H) : T.domain) : H) :=
      T.op_res hn (x : H)
    simp only [resCLM_apply]
    rw [h1.trans h2]
  have E3 : T.resCLM n (T.resCLM (-n) (T.op x))
      = T.resCLM n (x : H) - ((n : ℂ) * Complex.I) • T.resCLM n (T.resCLM (-n) (x : H)) := by
    rw [E1, map_sub, map_smul]
  rw [jn_apply, E2, E3]
  match_scalars <;> ring_nf
  simp [Complex.I_sq]
