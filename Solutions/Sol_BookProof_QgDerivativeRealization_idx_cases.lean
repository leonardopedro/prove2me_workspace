-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.idx_cases
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 84) :
    (∃ mu, j = idxX mu) ∨ (∃ mu a, j = idxE mu a) ∨ (∃ mu nu a, j = idxDE mu nu a) := by

  rcases lt_or_ge (j : ℕ) 4 with h | h
  · exact Or.inl ⟨⟨(j : ℕ), h⟩, Fin.ext rfl⟩
  · rcases lt_or_ge (j : ℕ) 20 with h2 | h2
    · exact Or.inr (Or.inl ⟨⟨((j : ℕ) - 4) / 4, by omega⟩, ⟨((j : ℕ) - 4) % 4, by omega⟩,
        Fin.ext (by simp only [idxE]; omega)⟩)
    · have hj := j.isLt
      exact Or.inr (Or.inr ⟨⟨((j : ℕ) - 20) / 16, by omega⟩,
        ⟨(((j : ℕ) - 20) / 4) % 4, by omega⟩, ⟨(j : ℕ) % 4, by omega⟩,
        Fin.ext (by simp only [idxDE]; omega)⟩)
