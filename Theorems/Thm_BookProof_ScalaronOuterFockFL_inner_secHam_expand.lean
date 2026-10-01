-- Generated from ChapterScalaronOuterFockFL.lean — theorem BookProof.ScalaronOuterFockFL.inner_secHam_expand
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

theorem BookProof.ScalaronOuterFockFL.inner_secHam_expand (x : secCore (ι := ι)) (z : Sec ι) {P : Finset ι}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0)
    (hP2 : ∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0) :
    (inner ℂ (secHam W Q x) z : ℂ)
      = (∑ a ∈ P, (inner ℂ (W.ham (Q.sig a) (fibOf x a)) ((z : ∀ _ : ι, L2R) a) : ℂ))
        + (∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
            (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) ((z : ∀ _ : ι, L2R) a) : ℂ))
        + ∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
            (inner ℂ (xCc (fibOf x b)) ((z : ∀ _ : ι, L2R) a) : ℂ) := by sorry
