-- Generated from ChapterSirkSingleTimeShift.lean — solution of BookProof.SirkSingleTime.res_sub_res
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore









open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint E) {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0) (y : E) :
    ((T.res l y : T.domain) : E) - ((T.res m y : T.domain) : E)
      = (((l - m : ℝ) : ℂ) * Complex.I) •
          ((T.res l ((T.res m y : T.domain) : E) : T.domain) : E) := by

  set x : T.domain := T.res m y with hx
  set u : T.domain := T.res l y with hu
  set w : T.domain := T.res l ((x : T.domain) : E) with hw
  have hux : T.shift l u = y := T.shift_res hl y
  have hwx : T.shift l w = ((x : T.domain) : E) := T.shift_res hl ((x : T.domain) : E)
  have hAx : T.op x = y + ((m : ℂ) * Complex.I) • ((x : T.domain) : E) := T.op_res hm y
  have hkey : T.shift l (u - x - ((((l - m : ℝ)) : ℂ) * Complex.I) • w) = 0 := by
    rw [map_sub, map_sub, map_smul, hux, hwx, UnboundedSelfAdjoint.shift_apply, hAx]
    push_cast
    module
  have hz : u - x - ((((l - m : ℝ)) : ℂ) * Complex.I) • w = 0 :=
    T.shift_injective hl (by rw [hkey, map_zero])
  have h' : (((u : T.domain) : E) - ((x : T.domain) : E))
      - ((((l - m : ℝ)) : ℂ) * Complex.I) • ((w : T.domain) : E) = 0 := by
    simpa using congrArg (fun z : T.domain => (z : E)) hz
  exact sub_eq_zero.mp h'
