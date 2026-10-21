-- Generated from ChapterQgOuterFockOneParticle.lean — solution of BookProof.QgOuterFockOneParticle.oneParticleOp_herm
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
import Theorems.Thm_BookProof_ScalaronOuterFockFL_xCc_symmetricOn
open BookProof.QgOuterFockOneParticle




open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (a b : ι) (v u : ccDomain ℝ) :
    (inner ℂ (oneParticleOp W Q b a v) ((u : L2R)) : ℂ)
      = inner ℂ (v : L2R) (oneParticleOp W Q a b u) := by

  classical
  rw [oneParticleOp_apply, oneParticleOp_apply]
  simp only [inner_add_left, inner_add_right, inner_smul_left, inner_smul_right]
  have hA : (starRingEnd ℂ) (Q.A b a) = Q.A a b := by
    rw [Q.A_herm a b]; simp
  have hB : (starRingEnd ℂ) (Q.B b a) = Q.B a b := by
    rw [Q.B_herm a b]; simp
  have hx : (inner ℂ (xCc v) ((u : L2R)) : ℂ) = inner ℂ (v : L2R) (xCc u) :=
    xCc_symmetricOn v u
  rw [hA, hB, hx]
  by_cases h : a = b
  · subst h
    rw [if_pos rfl, if_pos rfl]
    rw [W.ham_symmetricOn (Q.sig a) v u]
  · rw [if_neg h, if_neg (Ne.symm h)]
    simp
