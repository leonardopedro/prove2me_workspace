-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.double_sum_amgm
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterWallEsaSemibounded
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterA4
open BookProof.ScalaronOuterFockFL

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)
variable {ι : Type*}
variable (Q : QgModeData ι)
variable (W : WallPot) (Q : QgModeData ι)



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

theorem BookProof.ScalaronOuterFockFL.double_sum_amgm (P : Finset ι) (w : ι → ι → ℝ) (f g r : ι → ℝ)
    (hw : ∀ a b, 0 ≤ w a b)
    (hrow : ∀ a, ∑ b ∈ P, w a b ≤ r a) (hcol : ∀ b, ∑ a ∈ P, w a b ≤ r b) :
    ∑ a ∈ P, ∑ b ∈ P, w a b * (f a * g b)
      ≤ (1 / 2) * ((∑ a ∈ P, r a * f a ^ 2) + ∑ b ∈ P, r b * g b ^ 2) := by sorry
