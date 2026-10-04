-- Generated from ChapterQgOuterFockOneParticle.lean — theorem BookProof.QgOuterFockOneParticle.single_mem_secCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterA4
open BookProof.ScalaronEsa
open BookProof.QgOuterFockOneParticle

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)



open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section


theorem BookProof.QgOuterFockOneParticle.single_mem_secCore (b : ι) (u : ccDomain ℝ) :
    (lp.single 2 b ((u : L2R)) : Sec ι) ∈ secCore (ι := by sorry
