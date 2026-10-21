-- Generated from ChapterSpectralEnergyBound.lean — solution of BookProof.ChapterSpectralEnergyBound.norm_evolve
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
import Theorems.Thm_BookProof_ChapterSpectralEnergyBound_norm_evolve_apply
open BookProof.ChapterSpectralEnergyBound




variable {n : Type*} [Fintype n]

variable {n : Type*} [Fintype n]

set_option maxHeartbeats 1000000 in
theorem solution (f : n → ℝ) (t : ℝ) (v : EuclideanSpace ℂ n) :
    ‖evolve f t v‖ = ‖v‖ := by

  rw [EuclideanSpace.norm_eq, EuclideanSpace.norm_eq]
  congr 1
  exact Finset.sum_congr rfl fun i _ => by rw [norm_evolve_apply]
