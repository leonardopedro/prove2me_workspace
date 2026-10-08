-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.ham_x_comm_cc
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterWallEsaSemibounded
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronOuterFockFL



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)

theorem BookProof.ScalaronOuterFockFL.ham_x_comm_cc (u v : ccDomain ℝ) :
    (starRingEnd ℂ) (inner ℂ (xCc v) (W.ham s u) : ℂ) - (inner ℂ (xCc u) (W.ham s v) : ℂ)
      = -2 * (inner ℂ (u : L2R) (dCc v) : ℂ) := by sorry
