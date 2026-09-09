-- Generated from ChapterSirkTrotterKato.lean — theorem BookProof.ChapterSirkTrotterKato.hasDerivAt_stoneU_const_sub
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato










noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.hasDerivAt_stoneU_const_sub (S : UnboundedSelfAdjoint H) (z : S.domain) (t u : ℝ) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (z : H))
      (Complex.I • S.op ⟨S.stoneU (t - u) (z : H), S.stoneU_mem_domain (t - u) z⟩) u := by sorry
