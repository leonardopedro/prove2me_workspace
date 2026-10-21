-- Generated from ChapterQgOuterFockOneParticle.lean — solution of BookProof.QgOuterFockOneParticle.secHam_single
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
import Theorems.Thm_BookProof_QgOuterFockOneParticle_single_mem_secCore
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_apply
open BookProof.QgOuterFockOneParticle




open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (b : ι) (u : ccDomain ℝ) (a : ι) :
    (secHam W Q ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec ι) a
      = oneParticleOp W Q a b u := by

  classical
  set x : secCore (ι := ι) := ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ with hx
  have hfib : ∀ c : ι, fibOf x c = if c = b then u else 0 := by
    intro c
    by_cases hc : c = b
    · subst hc
      refine Subtype.ext ?_
      change (lp.single 2 c ((u : L2R)) : Sec ι) c = _
      rw [lp.single_apply, Pi.single_eq_same, if_pos rfl]
    · refine Subtype.ext ?_
      change (lp.single 2 b ((u : L2R)) : Sec ι) c = _
      rw [lp.single_apply, Pi.single_eq_of_ne hc, if_neg hc]
      rfl
  have hA : (∑ c ∈ Q.nbr a, Q.A a c • ((fibOf x c : ccDomain ℝ) : L2R))
      = Q.A a b • (u : L2R) := by
    by_cases hb : b ∈ Q.nbr a
    · rw [Finset.sum_eq_single b]
      · rw [hfib b, if_pos rfl]
      · intro c _ hc
        rw [hfib c, if_neg hc]
        simp
      · intro h; exact absurd hb h
    · rw [Q.A_off a b hb, zero_smul]
      refine Finset.sum_eq_zero fun c hc => ?_
      have hcb : c ≠ b := fun h => hb (h ▸ hc)
      rw [hfib c, if_neg hcb]
      simp
  have hB : (∑ c ∈ Q.nbr a, Q.B a c • xCc (fibOf x c)) = Q.B a b • xCc u := by
    by_cases hb : b ∈ Q.nbr a
    · rw [Finset.sum_eq_single b]
      · rw [hfib b, if_pos rfl]
      · intro c _ hc
        rw [hfib c, if_neg hc]
        simp
      · intro h; exact absurd hb h
    · rw [Q.B_off a b hb, zero_smul]
      refine Finset.sum_eq_zero fun c hc => ?_
      have hcb : c ≠ b := fun h => hb (h ▸ hc)
      rw [hfib c, if_neg hcb]
      simp
  rw [secHam_apply, hA, hB, oneParticleOp_apply, hfib a]
  by_cases h : a = b
  · subst h
    rw [if_pos rfl, if_pos rfl]
  · rw [if_neg h, if_neg h, map_zero]
