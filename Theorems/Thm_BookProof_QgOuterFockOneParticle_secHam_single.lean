-- Generated from ChapterQgOuterFockOneParticle.lean — theorem BookProof.QgOuterFockOneParticle.secHam_single
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa
open BookProof.QgOuterFockOneParticle



open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)


theorem BookProof.QgOuterFockOneParticle.secHam_single (b : ι) (u : ccDomain ℝ) (a : ι) :
    (secHam W Q ⟨lp.single 2 b ((u : L2R)), single_mem_secCore b u⟩ : Sec ι) a
      = oneParticleOp W Q a b u := by sorry
