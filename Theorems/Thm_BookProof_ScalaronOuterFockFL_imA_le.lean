-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.imA_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterWallEsaSemibounded
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterA4
open BookProof.ScalaronEsa

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

theorem BookProof.ScalaronOuterFockFL.imA_le (x : secCore (ι := ι)) (P : Finset ι) :
    |(∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
        (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im|
      ≤ (1 / 2) * Q.K * ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) := by sorry
