-- Generated from ChapterQgOuterFockOneParticle.lean — theorem BookProof.QgOuterFockOneParticle.secHam_matrix_element
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


theorem BookProof.QgOuterFockOneParticle.secHam_matrix_element (a b : ι) (v u : ccDomain ℝ) :
    (inner ℂ (lp.single 2 a ((v : L2R)) : Sec ι)
        (secHam W Q ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec ι) : ℂ)
      = inner ℂ (v : L2R) (oneParticleOp W Q a b u) := by sorry
