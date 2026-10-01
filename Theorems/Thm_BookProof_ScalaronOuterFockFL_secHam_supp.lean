-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.secHam_supp
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

theorem BookProof.ScalaronOuterFockFL.secHam_supp {P : Finset ι} {x : secCore (ι := ι)}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0)
    (hP2 : ∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0) (a : ι) (ha : a ∉ P) :
    (secHam W Q x : Sec ι) a = 0 := by sorry
