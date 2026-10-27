-- Generated from ChapterQgOuterFockOneParticle.lean — solution of BookProof.QgOuterFockOneParticle.oneParticleOp_off
import Mathlib
import Definitions.Def_ChapterQgOuterFockOneParticle
open BookProof.QgOuterFockOneParticle




open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL

noncomputable section

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

variable {ι : Type*} [DecidableEq ι] (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution {a b : ι} (hab : a ≠ b) (hb : b ∉ Q.nbr a) :
    oneParticleOp W Q a b = 0 := by

  ext u
  simp [oneParticleOp_apply, if_neg hab, Q.A_off a b hb, Q.B_off a b hb]
