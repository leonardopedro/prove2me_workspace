-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.dCc_eq
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded
open BookProof.ScalaronEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (f : ccSchwartz ℝ) : dCc (ccEquiv ℝ f) = derivL2 f := by

  rw [dCc, LinearEquiv.symm_apply_apply]
