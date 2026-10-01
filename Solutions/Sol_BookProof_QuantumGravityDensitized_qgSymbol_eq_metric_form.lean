-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgSymbol_eq_metric_form
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_qgMomenta_castSucc
import Theorems.Thm_BookProof_QuantumGravityDensitized_qgMomenta_last
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) :
    qgSymbol xi xiY
      = ∑ i, ∑ j, qgMetric n i j * qgMomenta xi xiY i * qgMomenta xi xiY j := by

  have hdiag : ∀ i j : Fin (n + 1), qgMetric n i j
      = if i = j then (if i = Fin.last n then -(1 / 24) else 1 / 16 : ℝ) else 0 := by
    intro i j
    by_cases h : i = j <;> simp [qgMetric, h]
  have hinner : ∀ i : Fin (n + 1),
      (∑ j, qgMetric n i j * qgMomenta xi xiY i * qgMomenta xi xiY j)
        = (if i = Fin.last n then -(1 / 24) else 1 / 16 : ℝ)
          * (qgMomenta xi xiY i * qgMomenta xi xiY i) := by
    intro i
    rw [Finset.sum_eq_single i]
    · simp [hdiag i i, mul_assoc]
    · intro j _ hj
      simp [hdiag i j, Ne.symm hj]
    · intro h; exact absurd (Finset.mem_univ i) h
  rw [Finset.sum_congr rfl fun i _ => hinner i]
  rw [Fin.sum_univ_castSucc]
  have hcast : ∀ a : Fin n,
      (if (a.castSucc : Fin (n + 1)) = Fin.last n then -(1 / 24) else 1 / 16 : ℝ)
        * (qgMomenta xi xiY (a.castSucc) * qgMomenta xi xiY (a.castSucc))
        = 1 / 16 * (xi a * xi a) := by
    intro a
    simp [Fin.castSucc_lt_last a |>.ne]
  rw [Finset.sum_congr rfl fun a _ => hcast a]
  simp only [qgMomenta_last, ← Finset.mul_sum]
  simp [qgSymbol, sq]
  ring
