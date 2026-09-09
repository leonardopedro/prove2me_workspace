-- Generated from ChapterSirkTrotterKato.lean — theorem BookProof.ChapterSirkTrotterKato.stoneU_shift
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato










noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.stoneU_shift (T : UnboundedSelfAdjoint H) (chi : T.domain) (u : ℝ) :
    T.shift 1 ⟨T.stoneU u (chi : H), T.stoneU_mem_domain u chi⟩
      = T.stoneU u (T.shift 1 chi) := by sorry
