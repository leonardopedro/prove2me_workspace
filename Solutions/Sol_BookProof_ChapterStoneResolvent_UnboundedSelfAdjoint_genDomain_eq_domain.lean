-- Generated from ChapterStoneTheorem.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.genDomain_eq_domain
import Mathlib
import Definitions.Def_ChapterStoneTheorem
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_domain_le_genDomain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_genOp_eq_op
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) :
    T.stoneGroup.genDomain = T.domain := by

  refine le_antisymm ?_ T.domain_le_genDomain
  intro x hx
  refine T.mem_domain_of_inner (eta := T.stoneGroup.genOp ⟨x, hx⟩) ?_
  intro psi
  have hpsi : (psi : H) ∈ T.stoneGroup.genDomain := T.domain_le_genDomain psi.2
  have hsym := T.stoneGroup.symmetric ⟨(psi : H), hpsi⟩ ⟨x, hx⟩
  rw [← T.genOp_eq_op psi]
  exact hsym
