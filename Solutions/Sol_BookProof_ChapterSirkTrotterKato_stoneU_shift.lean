-- Generated from ChapterSirkTrotterKato.lean — solution of BookProof.ChapterSirkTrotterKato.stoneU_shift
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato











noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) (chi : T.domain) (u : ℝ) :
    T.shift 1 ⟨T.stoneU u (chi : H), T.stoneU_mem_domain u chi⟩
      = T.stoneU u (T.shift 1 chi) := by

  rw [T.shift_apply, T.shift_apply, T.stoneU_op u chi, map_sub,
    ContinuousLinearMap.map_smul]
