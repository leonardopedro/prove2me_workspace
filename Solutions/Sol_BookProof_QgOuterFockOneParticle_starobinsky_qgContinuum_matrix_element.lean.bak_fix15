-- Generated from ChapterQgOuterFockOneParticle.lean — solution of BookProof.QgOuterFockOneParticle.starobinsky_qgContinuum_matrix_element
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
import Theorems.Thm_BookProof_QgOuterFockOneParticle_single_mem_secCore
import Theorems.Thm_BookProof_QgOuterFockOneParticle_secHam_matrix_element
open BookProof.QgOuterFockOneParticle




open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ)
    (a b : CMode) (v u : ccDomain ℝ) :
    (inner ℂ (lp.single 2 a ((v : L2R)) : Sec CMode)
        (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)
          ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec CMode) : ℂ)
      = inner ℂ (v : L2R)
          ((if a = b then (starobinskyWall M alpha halpha).ham (cSig b) u else 0)
            + contTorsionGram a b • (u : L2R) + contCoupling g a b • xCc u) := by

  rw [secHam_matrix_element, oneParticleOp_apply]
  rfl
