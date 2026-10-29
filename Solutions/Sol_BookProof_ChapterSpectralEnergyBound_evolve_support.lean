-- Generated from ChapterSpectralEnergyBound.lean — solution of BookProof.ChapterSpectralEnergyBound.evolve_support
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterSpectralEnergyBound
open BookProof.ChapterBornMeasure




variable {n : Type*} [Fintype n]

variable {n : Type*} [Fintype n]

/-- Mirror copy of `ChapterSpectralEnergyBound.evolve_apply` (dropped from the
published bundle): `rfl` by the definition of `evolve`. -/
private theorem evolve_apply' (f : n → ℝ) (t : ℝ) (v : EuclideanSpace ℂ n) (i : n) :
    evolve f t v i = Complex.exp (-Complex.I * (t : ℂ) * (f i : ℂ)) * v i := rfl

set_option maxHeartbeats 1000000 in

theorem solution (f : n → ℝ) (t : ℝ) (v : EuclideanSpace ℂ n) (i : n)
    (h : evolve f t v i ≠ 0) : v i ≠ 0 := by
  intro hv
  exact h (by simp [hv, evolve_apply'])
