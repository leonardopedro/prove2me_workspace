-- Generated from ChapterQgOuterFockOneParticle.lean — solution of BookProof.QgOuterFockOneParticle.oneParticleOp_off
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
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
theorem solution {a b : ι} (hab : a ≠ b) (hb : b ∉ Q.nbr a) :
    oneParticleOp W Q a b = 0 := by

  ext u
  simp [oneParticleOp_apply, if_neg hab, Q.A_off a b hb, Q.B_off a b hb]
