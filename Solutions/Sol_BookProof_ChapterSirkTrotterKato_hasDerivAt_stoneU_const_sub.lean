-- Generated from ChapterSirkTrotterKato.lean — solution of BookProof.ChapterSirkTrotterKato.hasDerivAt_stoneU_const_sub
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato











noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (S : UnboundedSelfAdjoint H) (z : S.domain) (t u : ℝ) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (z : H))
      (Complex.I • S.op ⟨S.stoneU (t - u) (z : H), S.stoneU_mem_domain (t - u) z⟩) u := by

  have h := S.hasDerivAt_stoneU_op z (t - u)
  have h2 : HasDerivAt (fun r : ℝ => S.stoneU (t - r) (z : H))
      (-((-Complex.I) • S.op ⟨S.stoneU (t - u) (z : H), S.stoneU_mem_domain (t - u) z⟩)) u :=
    h.comp_const_sub t u
  simpa using h2
