-- Generated from ChapterQgOuterFockOneParticle.lean — theorem BookProof.QgOuterFockOneParticle.starobinsky_qgContinuum_matrix_element
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa
open BookProof.QgOuterFockOneParticle

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)



open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section


theorem BookProof.QgOuterFockOneParticle.starobinsky_qgContinuum_matrix_element (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ)
    (a b : CMode) (v u : ccDomain ℝ) :
    (inner ℂ (lp.single 2 a ((v : L2R)) : Sec CMode)
        (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)
          ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec CMode) : ℂ)
      = inner ℂ (v : L2R)
          ((if a = b then (starobinskyWall M alpha halpha).ham (cSig b) u else 0)
            + contTorsionGram a b • (u : L2R) + contCoupling g a b • xCc u) := by sorry
