-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.rel_eq_of_invCLM_eq
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_of_mem
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (hT₁ : IsNonnegSelfAdjoint T₁) (hT₂ : IsNonnegSelfAdjoint T₂)
    (heq : invCLM hT₁ = invCLM hT₂) : T₁ = T₂ := by

  have key : ∀ {S₁ S₂ : Submodule ℂ (F × F)} (h1 : IsNonnegSelfAdjoint S₁)
      (h2 : IsNonnegSelfAdjoint S₂), invCLM h1 = invCLM h2 → S₁ ≤ S₂ := by
    intro S₁ S₂ h1 h2 he p hp
    have hx : invCLM h1 (p.1 + p.2) = p.1 := invCLM_eq_of_mem h1 (by simpa using hp)
    have hmem := invCLM_mem h2 (p.1 + p.2)
    rw [← he, hx] at hmem
    simpa using hmem
  exact le_antisymm (key hT₁ hT₂ heq) (key hT₂ hT₁ heq.symm)
