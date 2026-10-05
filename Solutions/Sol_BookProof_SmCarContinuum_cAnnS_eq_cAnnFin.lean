-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.cAnnS_eq_cAnnFin
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_cCreS_eq_cCreFin
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {f : Ell2} {J : Finset ℕ} (h : ∀ i, (f : ℕ → ℂ) i ≠ 0 → i ∈ J) :
    cAnnS f = cAnnFin J (fun i => f i) := by

  rw [cAnnS, cCreS_eq_cCreFin h]
  symm
  rw [ContinuousLinearMap.eq_adjoint_iff]
  intro x y
  have h1 := inner_cCreFin_left J (fun i => (f : ℕ → ℂ) i) y x
  have h2 := congrArg (starRingEnd ℂ) h1
  rw [inner_conj_symm, inner_conj_symm] at h2
  exact h2.symm
