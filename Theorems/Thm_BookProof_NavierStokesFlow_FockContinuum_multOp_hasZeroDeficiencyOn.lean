-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.multOp_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

)) 2 μ := by
  refine ⟨Complex.continuous_conj.comp_aestronglyMeasurable h.1, ?_⟩
  have heq : eLpNorm (fun x => (starRingEnd ℂ) (F x)) 2 μ = eLpNorm F 2 μ := by
    refine eLpNorm_congr_norm_ae ?_
    filter_upwards with x
    simp
  rw [heq]
  exact h.2

/-! ## Essential self-adjointness -/

/-- **Multiplication by a real measurable function is essentially self-adjoint on
the bounded-energy core.**  This is the continuum counterpart of the
occupation-number statement: the operator he := by sorry
