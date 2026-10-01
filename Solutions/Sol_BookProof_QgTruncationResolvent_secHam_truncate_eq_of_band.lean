-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.secHam_truncate_eq_of_band
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_apply
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (Λ : Set ι) {x : secCore (ι := ι)} {P : Finset ι}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0)
    (hP2 : ∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0)
    (hPΛ : ∀ a ∈ P, a ∈ Λ) :
    secHam W (truncModes Q Λ) x = secHam W Q x := by

  classical
  refine lp.ext (funext fun a => ?_)
  rw [secHam_apply, secHam_apply]
  simp only [truncModes_sig, truncModes_nbr]
  have hmem : ∀ b ∈ Q.nbr a, (x : Sec ι) b ≠ 0 → (a ∈ Λ ∧ b ∈ Λ) := by
    intro b hb hne
    have hbP : b ∈ P := by by_contra hc; exact hne (hP1 b hc)
    have haP : a ∈ P := by
      by_contra hc
      exact hne (hP2 a hc b hb)
    exact ⟨hPΛ a haP, hPΛ b hbP⟩
  have hA : ∀ b ∈ Q.nbr a,
      (truncModes Q Λ).A a b • ((fibOf x b : ccDomain ℝ) : L2R)
        = Q.A a b • ((fibOf x b : ccDomain ℝ) : L2R) := by
    intro b hb
    by_cases hne : (x : Sec ι) b = 0
    · rw [fibOf_eq_zero hne]
      simp
    · have h := hmem b hb hne
      simp only [truncModes]
      rw [if_pos h]
  have hB : ∀ b ∈ Q.nbr a,
      (truncModes Q Λ).B a b • xCc (fibOf x b) = Q.B a b • xCc (fibOf x b) := by
    intro b hb
    by_cases hne : (x : Sec ι) b = 0
    · rw [fibOf_eq_zero hne]
      simp
    · have h := hmem b hb hne
      simp only [truncModes]
      rw [if_pos h]
  rw [Finset.sum_congr rfl hA, Finset.sum_congr rfl hB]
