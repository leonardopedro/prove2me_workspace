-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.imB_le
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
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

theorem BookProof.ScalaronOuterFockFL.imB_le (x : secCore (ι := ι)) (P : Finset ι) :
    |(∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
        (inner ℂ (xCc (fibOf x b)) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im|
      ≤ (9 / 4) * Q.K * ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) := by sorry
