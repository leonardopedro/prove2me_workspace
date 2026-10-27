-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.car_smeared_of_finite_right
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_lipschitz_cAnnS
import Theorems.Thm_BookProof_SmCarContinuum_car_smeared_of_finite
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {g : Ell2} (hg : g ∈ lpFiniteModes ℕ) (ψ : CFock)
    (f : Ell2) :
    cAnnS f (cCreS g ψ) + cCreS g (cAnnS f ψ) = (inner ℂ f g : ℂ) • ψ := by

  have hcont1 : Continuous fun f : Ell2 => cAnnS f (cCreS g ψ) + cCreS g (cAnnS f ψ) :=
    ((ContinuousLinearMap.apply ℂ CFock (cCreS g ψ)).continuous.comp
        lipschitz_cAnnS.continuous).add
      ((cCreS g).continuous.comp
        ((ContinuousLinearMap.apply ℂ CFock ψ).continuous.comp lipschitz_cAnnS.continuous))
  have hcont2 : Continuous fun f : Ell2 => (inner ℂ f g : ℂ) • ψ := by fun_prop
  exact congrFun (Continuous.ext_on lpFiniteModes_dense hcont1 hcont2
    (fun x hx => car_smeared_of_finite hx hg ψ)) f
