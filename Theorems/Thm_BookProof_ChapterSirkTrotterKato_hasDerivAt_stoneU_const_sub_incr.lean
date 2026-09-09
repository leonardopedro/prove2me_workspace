-- Generated from ChapterSirkTrotterKato.lean — theorem BookProof.ChapterSirkTrotterKato.hasDerivAt_stoneU_const_sub_incr
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato










noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.hasDerivAt_stoneU_const_sub_incr (S : UnboundedSelfAdjoint H) {y : ℝ → H} {y' : H}
    {t u : ℝ} (hy : HasDerivAt y y' u) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (y r - y u)) (S.stoneU (t - u) y') u := by sorry
