-- Generated from ChapterQgOuterFockOneParticle.lean — solution of BookProof.QgOuterFockOneParticle.secHam_eq_sum_oneParticle
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.QgOuterFockOneParticle




open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa

noncomputable section

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in

theorem solution (x : secCore (ι := ι)) (a : ι) :
    (secHam W Q x : Sec ι) a
      = ∑ b ∈ insert a (Q.nbr a), oneParticleOp W Q a b (fibOf x b) := by
  classical
  have key : ∀ f : ι → L2R, (∀ c, c ∉ Q.nbr a → f c = 0) →
      ∑ c ∈ insert a (Q.nbr a), f c = ∑ c ∈ Q.nbr a, f c := by
    intro f hf
    by_cases ha : a ∈ Q.nbr a
    · rw [Finset.insert_eq_self.mpr ha]
    · rw [Finset.sum_insert ha, hf a ha, zero_add]
  simp only [oneParticleOp_apply]
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib,
    key (fun c => Q.A a c • ((fibOf x c : ccDomain ℝ) : L2R))
      (fun c hc => by simp [Q.A_off a c hc]),
    key (fun c => Q.B a c • xCc (fibOf x c)) (fun c hc => by simp [Q.B_off a c hc]),
    secHam_apply]
  congr 2
  rw [Finset.sum_ite_eq (insert a (Q.nbr a)) a (fun c => W.ham (Q.sig c) (fibOf x c)),
    if_pos (Finset.mem_insert_self a (Q.nbr a))]

/-! ## The physical continuum instance -/
