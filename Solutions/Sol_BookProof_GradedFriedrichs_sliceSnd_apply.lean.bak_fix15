-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.sliceSnd_apply
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (a : α) (u : (α × β) →₀ ℂ) (b : β) : sliceSnd a u b = u (a, b) := by

  classical
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg => rw [map_add, Finsupp.add_apply, hf, hg, Finsupp.add_apply]
  | single p c =>
    obtain ⟨a₀, b₀⟩ := p
    rw [sliceSnd, Finsupp.lsum_single, LinearMap.toSpanSingleton_apply]
    simp only [Finsupp.smul_apply, smul_eq_mul, Finsupp.single_apply, Prod.mk.injEq]
    by_cases hb : b₀ = b <;> by_cases ha : a₀ = a <;> simp [ha, hb]
