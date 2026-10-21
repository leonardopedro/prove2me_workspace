-- Generated from ChapterSpectralEnergyBound.lean — solution of BookProof.ChapterSpectralEnergyBound.norm_evolve_apply
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
open BookProof.ChapterSpectralEnergyBound




variable {n : Type*} [Fintype n]

variable {n : Type*} [Fintype n]

set_option maxHeartbeats 1000000 in
theorem solution (f : n → ℝ) (t : ℝ) (v : EuclideanSpace ℂ n) (i : n) :
    ‖evolve f t v i‖ = ‖v i‖ := by

  have habs : ‖Complex.exp (-Complex.I * (t : ℂ) * (f i : ℂ))‖ = 1 := by
    rw [Complex.norm_exp]
    simp
  rw [evolve_apply, norm_mul, habs, one_mul]
