-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.boundedEnergyCore_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

imp only [one_div] at h
  rw [show (0 : ENNReal) ^ (2 : ℝ)⁻¹ = 0 from ENNReal.zero_rpow_of_pos (by norm_num)] at h
  have hfun : ∀ I : ℕ → ENNReal,
      (fun a : ENNReal => a ^ (2:ℝ)⁻¹) ∘ I = fun n => I n ^ (2:ℝ)⁻¹ := fun I => rfl
  simp only [one_div]
  rw [← hfun]
  exact h

/-- **The bounded-energy core is dense.**  Every square-integrable state is the
`L²`-limit of its := by sorry
