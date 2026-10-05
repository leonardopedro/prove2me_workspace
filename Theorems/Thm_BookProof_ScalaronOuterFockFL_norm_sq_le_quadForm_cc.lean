-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.norm_sq_le_quadForm_cc
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterWallEsaSemibounded
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronOuterFockFL

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

theorem BookProof.ScalaronOuterFockFL.norm_sq_le_quadForm_cc (hs : 1 ≤ s) (u : ccDomain ℝ) :
    ‖(u : L2R)‖ ^ 2 ≤ quadForm (W.ham s) u := by sorry
