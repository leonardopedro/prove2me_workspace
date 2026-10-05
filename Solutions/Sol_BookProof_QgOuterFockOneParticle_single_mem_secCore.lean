-- Generated from ChapterQgOuterFockOneParticle.lean — solution of BookProof.QgOuterFockOneParticle.single_mem_secCore
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
theorem solution (b : ι) (u : ccDomain ℝ) :
    (lp.single 2 b ((u : L2R)) : Sec ι) ∈ secCore (ι := single_mem_dsCore (G := fun _ : ι => L2R) (D := fun _ : ι => ccDomain ℝ) b u
