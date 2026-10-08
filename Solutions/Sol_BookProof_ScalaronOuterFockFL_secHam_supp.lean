-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.secHam_supp
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_apply
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
theorem solution {P : Finset ι} {x : secCore (ι :=
  ι)}
      (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0)
      (hP2 : ∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0) (a : ι) (ha : a ∉ P) :
      (secHam W Q x : Sec ι) a = 0 := by
    rw [secHam_apply]
    have h1 : W.ham (Q.sig a) (fibOf x a) = 0 := by
      rw [fibOf_eq_zero (hP1 a ha), map_zero]
    have h2 : ∑ b ∈ Q.nbr a, Q.A a b • ((fibOf x b : ccDomain ℝ) : L2R) = 0 :=
      Finset.sum_eq_zero fun b hb => by rw [fibOf_eq_zero (hP2 a ha b hb)]; simp
    have h3 : ∑ b ∈ Q.nbr a, Q.B a b • xCc (fibOf x b) = 0 :=
      Finset.sum_eq_zero fun b hb => by
        rw [fibOf_eq_zero (hP2 a ha b hb), map_zero, smul_zero]
    rw [h1, h2, h3]
    simp
