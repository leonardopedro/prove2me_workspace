-- Generated from ChapterSirkTrotterKato.lean — theorem BookProof.ChapterSirkTrotterKato.resolvent_commutator_eq
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato










noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.resolvent_commutator_eq (T S : UnboundedSelfAdjoint H) (y : T.domain) :
    S.op ⟨S.resCLM 1 (y : H), S.resCLM_mem 1 (y : H)⟩ - S.resCLM 1 (T.op y)
      = T.resCLM 1 (T.shift 1 y) - S.resCLM 1 (T.shift 1 y) := by sorry
