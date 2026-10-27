-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.real_relBound
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {φ w s h q l c ε : ℝ} (hl : 0 < l) (hc : 0 ≤ c) (hε : 0 < ε)
    (hs : 0 ≤ s) (hh : 0 ≤ h) (hφ0 : 0 ≤ φ)
    (h1 : φ ^ 2 ≤ 2 / l * w ^ 2 + c * s ^ 2) (h2 : w ^ 2 ≤ 2 * q) (h3 : q ≤ s * h) :
    φ ≤ ε * h + Real.sqrt ((4 / l) ^ 2 / (4 * ε ^ 2) + c) * s := by

  set A : ℝ := 4 / l with hA
  set K : ℝ := Real.sqrt (A ^ 2 / (4 * ε ^ 2) + c) with hK
  have hl' : 0 < 2 / l := by positivity
  have hsq : φ ^ 2 ≤ A * s * h + c * s ^ 2 := by
    have : 2 / l * w ^ 2 ≤ 2 / l * (2 * (s * h)) :=
      mul_le_mul_of_nonneg_left (h2.trans (by linarith)) hl'.le
    have e : 2 / l * (2 * (s * h)) = A * s * h := by rw [hA]; ring
    linarith
  have hamgm : A * s * h ≤ ε ^ 2 * h ^ 2 + A ^ 2 / (4 * ε ^ 2) * s ^ 2 := by
    have key : 0 ≤ (ε * h - A * s / (2 * ε)) ^ 2 := sq_nonneg _
    have e1 : (ε * h - A * s / (2 * ε)) ^ 2
        = ε ^ 2 * h ^ 2 - A * s * h + A ^ 2 / (4 * ε ^ 2) * s ^ 2 := by
      field_simp
      ring
    linarith
  have hK2 : K ^ 2 = A ^ 2 / (4 * ε ^ 2) + c := by
    rw [hK, Real.sq_sqrt (by positivity)]
  have hK0 : 0 ≤ K := Real.sqrt_nonneg _
  have hfin : φ ^ 2 ≤ (ε * h + K * s) ^ 2 := by
    have e : (ε * h + K * s) ^ 2 = ε ^ 2 * h ^ 2 + 2 * ε * K * h * s + K ^ 2 * s ^ 2 := by ring
    rw [e, hK2]
    have : 0 ≤ 2 * ε * K * h * s := by positivity
    nlinarith
  exact (pow_le_pow_iff_left₀ hφ0 (by positivity) two_ne_zero).mp hfin
