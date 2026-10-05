-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.xCc_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronEsa_smoothPotential_symmetric
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)
variable {ι : Type*}
variable (Q : QgModeData ι)
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (ccDomain ℝ) xCc := smoothPotential_symmetric (fun x : ℝ => x) contDiff_id
