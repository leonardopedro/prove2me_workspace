-- Generated from ChapterQgOuterFockOneParticle.lean — theorem BookProof.QgOuterFockOneParticle.oneParticleOp_off
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


theorem BookProof.QgOuterFockOneParticle.oneParticleOp_off {a b : ι} (hab : a ≠ b) (hb : b ∉ Q.nbr a) :
    oneParticleOp W Q a b = 0 := by sorry
