-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.secHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_fibOf_coe
import Theorems.Thm_BookProof_ScalaronOuterFockFL_xCc_symmetricOn
import Theorems.Thm_BookProof_ScalaronOuterFockFL_exists_band₂
import Theorems.Thm_BookProof_ScalaronOuterFockFL_inner_secHam_expand
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (secCore (ι := ι)) (secHam W Q) := by

  intro x y
  obtain ⟨P, hx1, hx2, hy1, hy2⟩ := exists_band₂ Q x y
  have hL := inner_secHam_expand W Q x (y : Sec ι) hx1 hx2
  have hR := inner_secHam_expand W Q y (x : Sec ι) hy1 hy2
  have hconj : (inner ℂ ((x : Sec ι)) (secHam W Q y) : ℂ)
      = (starRingEnd ℂ) (inner ℂ (secHam W Q y) ((x : Sec ι)) : ℂ) :=
    (inner_conj_symm _ _).symm
  rw [hL, hconj, hR]
  simp only [map_add, map_sum, map_mul, RingHomCompTriple.comp_apply, RingHom.id_apply]
  congr 1
  · congr 1
    · exact Finset.sum_congr rfl fun a _ => by
        rw [← fibOf_coe y a, ← fibOf_coe x a,
          W.ham_symmetricOn (Q.sig a) (fibOf x a) (fibOf y a), inner_conj_symm]
    · rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
      rw [Q.A_herm b a, inner_conj_symm]
      simp
  · rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [← fibOf_coe y b, ← fibOf_coe x a, Q.B_herm b a, inner_conj_symm,
      xCc_symmetricOn (fibOf x a) (fibOf y b)]
