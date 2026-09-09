-- Generated from ChapterSirkTrotterKato.lean — theorem BookProof.ChapterSirkTrotterKato.hasDerivAt_stoneU_const_sub_apply
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato










noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.hasDerivAt_stoneU_const_sub_apply (S : UnboundedSelfAdjoint H) {y : ℝ → H} {y' : H}
    {t u : ℝ} (hy : HasDerivAt y y' u) (hmem : y u ∈ S.domain) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (y r))
      (Complex.I • S.op ⟨S.stoneU (t - u) (y u), S.stoneU_mem_domain (t - u) ⟨y u, hmem⟩⟩
        + S.stoneU (t - u) y') u := by sorry
