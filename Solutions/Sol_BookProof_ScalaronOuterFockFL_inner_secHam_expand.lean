-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.inner_secHam_expand
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_supp
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : secCore (ι := ι)) (z : Sec ι) {P : Finset ι}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0)
    (hP2 : ∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0) :
    (inner ℂ (secHam W Q x) z : ℂ)
      = (∑ a ∈ P, (inner ℂ (W.ham (Q.sig a) (fibOf x a)) ((z : ∀ _ : ι, L2R) a) : ℂ))
        + (∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
            (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) ((z : ∀ _ : ι, L2R) a) : ℂ))
        + ∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
            (inner ℂ (xCc (fibOf x b)) ((z : ∀ _ : ι, L2R) a) : ℂ) := by

  rw [inner_eq_sum_of_supp P _ z (secHam_supp W Q hP1 hP2)]
  have hterm : ∀ a ∈ P, (inner ℂ ((secHam W Q x : Sec ι) a) ((z : ∀ _ : ι, L2R) a) : ℂ)
      = (inner ℂ (W.ham (Q.sig a) (fibOf x a)) ((z : ∀ _ : ι, L2R) a) : ℂ)
        + (∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
            (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) ((z : ∀ _ : ι, L2R) a) : ℂ))
        + ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
            (inner ℂ (xCc (fibOf x b)) ((z : ∀ _ : ι, L2R) a) : ℂ) := by
    intro a _
    have hA : (secA Q x : Sec ι) a = ∑ b ∈ P, Q.A a b • ((fibOf x b : ccDomain ℝ) : L2R) :=
      modeOp_eq_sum_band Q _ _ Q.A_off hP1 a
    have hB : (secB Q x : Sec ι) a = ∑ b ∈ P, Q.B a b • xCc (fibOf x b) :=
      modeOp_eq_sum_band Q _ _ Q.B_off hP1 a
    have hsplit : (secHam W Q x : Sec ι) a
        = W.ham (Q.sig a) (fibOf x a) + (secA Q x : Sec ι) a + (secB Q x : Sec ι) a := by
      change ((secDiag W Q x + secA Q x + secB Q x : Sec ι)) a = _
      rw [lp.coeFn_add, lp.coeFn_add]
      rfl
    rw [hsplit, hA, hB, inner_add_left, inner_add_left, sum_inner, sum_inner]
    congr 1
    · congr 1
      exact Finset.sum_congr rfl fun b _ => inner_smul_left _ _ _
    · exact Finset.sum_congr rfl fun b _ => inner_smul_left _ _ _
  rw [Finset.sum_congr rfl hterm, Finset.sum_add_distrib, Finset.sum_add_distrib]
