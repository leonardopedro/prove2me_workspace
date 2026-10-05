-- Generated from ChapterQgOuterFockOneParticle.lean — solution of BookProof.QgOuterFockOneParticle.secHam_matrix_element
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
import Theorems.Thm_BookProof_QgOuterFockOneParticle_single_mem_secCore
import Theorems.Thm_BookProof_QgOuterFockOneParticle_secHam_single
open BookProof.QgOuterFockOneParticle




open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (a b : ι) (v u : ccDomain ℝ) :
    (inner ℂ (lp.single 2 a ((v : L2R)) : Sec ι)
        (secHam W Q ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec ι) : ℂ)
      = inner ℂ (v : L2R) (oneParticleOp W Q a b u) := by

  rw [lp.inner_single_left, secHam_single]
