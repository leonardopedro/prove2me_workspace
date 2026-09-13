-- Generated from ChapterStoneResolvent.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_op
import Mathlib
import Definitions.Def_ChapterStoneResolvent
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_shift
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint







open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]



variable (T : UnboundedSelfAdjoint H)













variable [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {l : ℝ} (hl : l ≠ 0) (x : T.domain) :
    ((T.res l (T.op x) : T.domain) : H) = T.op (T.res l (x : H)) := by

  set w : T.domain := T.res l (x : H) with hw
  have hAw : T.op w = (x : H) + ((l : ℂ) * Complex.I) • (w : H) := T.op_res hl (x : H)
  have hmem : T.op w ∈ T.domain := by
    rw [hAw]
    exact T.domain.add_mem x.2 (T.domain.smul_mem _ w.2)
  have hsub : (⟨T.op w, hmem⟩ : T.domain) = x + ((l : ℂ) * Complex.I) • w := by
    apply Subtype.ext
    simpa using hAw
  have hshift : T.shift l ⟨T.op w, hmem⟩ = T.op x := by
    rw [shift_apply, hsub, map_add, map_smul]
    simp only [Submodule.coe_add, Submodule.coe_smul]
    rw [hAw]
    module
  have := T.res_shift hl ⟨T.op w, hmem⟩
  rw [hshift] at this
  rw [this]
