-- Generated from ChapterNavierStokesFockContinuum.lean — solution of BookProof.NavierStokesFlow.FockContinuum.memLp_conj
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum



open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in

theorem solution {μ : Measure X} {F : X → ℂ} (h : MemLp F 2 μ) :
    MemLp (fun x => (starRingEnd ℂ) (F x)) 2 μ := by
  refine ⟨Complex.continuous_conj.comp_aestronglyMeasurable h.1, ?_⟩
  have heq : eLpNorm (fun x => (starRingEnd ℂ) (F x)) 2 μ = eLpNorm F 2 μ := by
    refine eLpNorm_congr_norm_ae ?_
    filter_upwards with x
    simp
  rw [heq]
  exact h.2

/-! ## Essential self-adjointness -/
