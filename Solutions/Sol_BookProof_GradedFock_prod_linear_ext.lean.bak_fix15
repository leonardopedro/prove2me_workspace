-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.prod_linear_ext
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_single_eq_otimes
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {N : Type*} [AddCommGroup N] [Module ℂ N]
    {f g : ((α × β) →₀ ℂ) →ₗ[ℂ] N}
    (h : ∀ (v : α →₀ ℂ) (w : β →₀ ℂ), f (otimes v w) = g (otimes v w)) : f = g := by

  refine LinearMap.ext fun u => ?_
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add p q hp hq => rw [map_add, map_add, hp, hq]
  | single ab c =>
    obtain ⟨a, b⟩ := ab
    rw [single_eq_otimes]
    exact h _ _
