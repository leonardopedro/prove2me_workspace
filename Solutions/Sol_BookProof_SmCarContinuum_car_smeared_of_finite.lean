-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.car_smeared_of_finite
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_cCreS_eq_cCreFin
import Theorems.Thm_BookProof_SmCarContinuum_cAnnS_eq_cAnnFin
import Theorems.Thm_BookProof_SmCarContinuum_inner_eq_finsum
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {f g : Ell2}
    (hf : f ∈ lpFiniteModes ℕ) (hg : g ∈ lpFiniteModes ℕ) (ψ : CFock) :
    cAnnS f (cCreS g ψ) + cCreS g (cAnnS f ψ) = (inner ℂ f g : ℂ) • ψ := by

  classical
  have hf_prime : (Function.support ((f : ℕ → ℂ))).Finite := hf
  have hg' : (Function.support ((g : ℕ → ℂ))).Finite := hg
  set J := hf_prime.toFinset ∪ hg'.toFinset with hJ
  have hfJ : ∀ i, (f : ℕ → ℂ) i ≠ 0 → i ∈ J := fun i hi =>
    Finset.mem_union_left _ (hf_prime.mem_toFinset.mpr hi)
  have hgJ : ∀ i, (g : ℕ → ℂ) i ≠ 0 → i ∈ J := fun i hi =>
    Finset.mem_union_right _ (hg'.mem_toFinset.mpr hi)
  rw [cAnnS_eq_cAnnFin hfJ, cCreS_eq_cCreFin hgJ, inner_eq_finsum (g := g) hfJ]
  exact car_cCreFin J _ _ ψ
