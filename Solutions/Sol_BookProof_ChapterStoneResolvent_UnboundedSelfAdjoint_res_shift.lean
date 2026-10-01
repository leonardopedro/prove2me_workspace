-- Generated from ChapterStoneResolvent.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_shift
import Mathlib
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
g hl]
  exact (T.shiftEquiv hl).apply_symm_apply y

theorem solution {l : ℝ} (hl : :=
  l ≠ 0) (x : T.domain) : T.res l (T.shift l x) = x := by
    rw [res, dif_
