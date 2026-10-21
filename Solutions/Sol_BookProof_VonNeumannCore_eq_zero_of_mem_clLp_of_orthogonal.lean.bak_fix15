-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.eq_zero_of_mem_clLp_of_orthogonal
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_factorRel_witness
import Theorems.Thm_BookProof_VonNeumannCore_mem_coreLp_iff
import Theorems.Thm_BookProof_ClosureUniqueness_adjGraph_eq_adjPairs_clGraph
import Theorems.Thm_BookProof_FriedrichsSquare_exists_mem_factorRel_add
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) {q : WithLp 2 (F × F)} (hq : q ∈ clLp A)
    (horth : q ∈ (coreLp A)ᗮ) : q = 0 := by

  have hqG : ((WithLp.ofLp q).1, (WithLp.ofLp q).2) ∈ clGraph A := hq
  have hx : (WithLp.ofLp q).1 = 0 := by
    have hall : ∀ h : F, (inner ℂ h (WithLp.ofLp q).1 : ℂ) = 0 := by
      intro h
      obtain ⟨p, hp, hsum⟩ := exists_mem_factorRel_add A h
      obtain ⟨y, hy, hz, -⟩ := factorRel_witness hp
      have hu : (WithLp.toLp 2 (p.1, y)) ∈ coreLp A := by
        refine mem_coreLp_iff.2 ?_
        exact ⟨by simpa using hy, by simpa using mem_frDom_iff.2 ⟨p.2, hp⟩⟩
      have h0 := horth _ hu
      rw [WithLp.prod_inner_apply] at h0
      have hyw : (inner ℂ y (WithLp.ofLp q).2 : ℂ) = inner ℂ p.2 (WithLp.ofLp q).1 := by
        rw [adjGraph_eq_adjPairs_clGraph] at hz
        have hr := hz ((WithLp.ofLp q).1, (WithLp.ofLp q).2) hqG
        have := congrArg (starRingEnd ℂ) hr
        rwa [inner_conj_symm, inner_conj_symm] at this
      rw [hyw] at h0
      rw [← hsum, inner_add_left]
      exact h0
    have := hall (WithLp.ofLp q).1
    exact inner_self_eq_zero.1 this
  have hw : (WithLp.ofLp q).2 = 0 := by
    refine clGraph_snd_eq_zero_of_fst_eq_zero hdense hsym ?_
    rw [← hx]
    exact hqG
  have hz : WithLp.ofLp q = (0 : F × F) := Prod.ext hx hw
  have := congrArg (WithLp.toLp 2) hz
  simpa using this
