-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.exists_band₂
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterWallEsaSemibounded
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterA4

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (W : WallPot) (s : ℝ)
variable {ι : Type*}
variable (Q : QgModeData ι)
variable (W : WallPot) (Q : QgModeData ι)



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.WallEsaSemibounded

noncomputable section

theorem BookProof.ScalaronOuterFockFL.exists_band₂₂ (x y : secCore (ι := ι)) :
    ∃ P : Finset ι, (∀ a, a ∉ P → (x : Sec ι) a = 0) ∧
      (∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0) ∧
      (∀ a, a ∉ P → (y : Sec ι) a = 0) ∧
      (∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (y : Sec ι) b = 0) := by sorry
