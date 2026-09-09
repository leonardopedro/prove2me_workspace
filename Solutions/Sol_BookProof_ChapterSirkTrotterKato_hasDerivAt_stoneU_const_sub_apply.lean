-- Generated from ChapterSirkTrotterKato.lean — solution of BookProof.ChapterSirkTrotterKato.hasDerivAt_stoneU_const_sub_apply
import Mathlib
import Definitions.Def_ChapterSirkTrotterKato
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_hasDerivAt_stoneU_const_sub
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_hasDerivAt_stoneU_const_sub_incr
open BookProof.ChapterSirkTrotterKato











noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace


open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (S : UnboundedSelfAdjoint H) {y : ℝ → H} {y' : H}
    {t u : ℝ} (hy : HasDerivAt y y' u) (hmem : y u ∈ S.domain) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (y r))
      (Complex.I • S.op ⟨S.stoneU (t - u) (y u), S.stoneU_mem_domain (t - u) ⟨y u, hmem⟩⟩
        + S.stoneU (t - u) y') u := by

  have h1 := hasDerivAt_stoneU_const_sub S ⟨y u, hmem⟩ t u
  have h2 := hasDerivAt_stoneU_const_sub_incr S hy (t := t)
  have heq : (fun r : ℝ => S.stoneU (t - r) ((⟨y u, hmem⟩ : S.domain) : H))
      + (fun r : ℝ => S.stoneU (t - r) (y r - y u)) = fun r : ℝ => S.stoneU (t - r) (y r) := by
    funext r
    simp only [Pi.add_apply, map_sub]
    abel
  have := h1.add h2
  rwa [heq] at this
