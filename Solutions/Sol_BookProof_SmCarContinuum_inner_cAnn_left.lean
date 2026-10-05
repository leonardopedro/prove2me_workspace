-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.inner_cAnn_left
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : ℕ) (ψ φ : CFock) :
    (inner ℂ (cAnn i ψ) φ : ℂ) = inner ℂ ψ (cCre i φ) := by

  have h := inner_cCre_left i φ ψ
  have h2 := congrArg (starRingEnd ℂ) h
  rw [inner_conj_symm, inner_conj_symm] at h2
  exact h2.symm
