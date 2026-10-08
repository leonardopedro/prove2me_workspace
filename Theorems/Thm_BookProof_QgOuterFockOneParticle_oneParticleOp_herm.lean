-- Generated from ChapterQgOuterFockOneParticle.lean — theorem BookProof.QgOuterFockOneParticle.oneParticleOp_herm
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


theorem BookProof.QgOuterFockOneParticle.oneParticleOp_herm (a b : ι) (v u : ccDomain ℝ) :
    (inner ℂ (oneParticleOp W Q b a v) ((u : L2R)) : ℂ)
      = inner ℂ (v : L2R) (oneParticleOp W Q a b u) := by sorry
