-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.secHam_commForm_le
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_inner_secHam_expand
import Theorems.Thm_BookProof_ScalaronOuterFockFL_imA_le
import Theorems.Thm_BookProof_ScalaronOuterFockFL_imB_le
import Theorems.Thm_BookProof_ScalaronOuterFockFL_quadForm_secDiag_eq
import Theorems.Thm_BookProof_FarisLavine_commForm_eq
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : secCore (ι := ι)) :
    |commForm (secHam W Q) (secDiag W Q) x| ≤ (6 * Q.K) * quadForm (secDiag W Q) x := by

  classical
  obtain ⟨P, hP1, hP2⟩ := exists_band Q x
  have hSq : quadForm (secDiag W Q) x
      = ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) := quadForm_secDiag_eq W Q x hP1
  have hSnn : (0 : ℝ) ≤ ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) :=
    Finset.sum_nonneg fun a _ => ham_quadForm_nonneg W (Q.sig a) (Q.sig_nonneg a) _
  have hexp := inner_secHam_expand W Q x (secDiag W Q x : Sec ι) hP1 hP2
  simp only [secDiag_apply] at hexp
  have h1 : (∑ a ∈ P, (inner ℂ (W.ham (Q.sig a) (fibOf x a))
      (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im = 0 := by
    rw [Complex.im_sum]
    exact Finset.sum_eq_zero fun a _ => by simpa using inner_self_im (𝕜 := ℂ) _
  have h2 := imA_le W Q x P
  have h3 := imB_le W Q x P
  have him : (inner ℂ (secHam W Q x) (secDiag W Q x : Sec ι) : ℂ).im
      = (∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
            (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im
        + (∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
            (inner ℂ (xCc (fibOf x b)) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im := by
    rw [hexp, Complex.add_im, Complex.add_im, h1, zero_add]
  have hKS : 0 ≤ Q.K * ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) :=
    mul_nonneg Q.K_nonneg hSnn
  rw [commForm_eq, him, hSq]
  have habs : |(-2 : ℝ) * ((∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
        (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im
      + (∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
        (inner ℂ (xCc (fibOf x b)) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im)|
      = 2 * |(∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
        (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im
      + (∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
        (inner ℂ (xCc (fibOf x b)) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im| := by
    rw [abs_mul]
    norm_num
  rw [habs]
  have htri := abs_add_le ((∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
        (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im)
      ((∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
        (inner ℂ (xCc (fibOf x b)) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im)
  linarith
