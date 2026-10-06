-- Generated from ChapterShannonSampling.lean — solution of BookProof.ChapterShannonSampling.integrableOn_spectrum
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling




open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

set_option maxHeartbeats 1000000 in
theorem solution (F : Lp ℂ 2 (haarAddCircle (T := T))) :
    IntegrableOn (fun ξ : ℝ => (F : AddCircle T → ℂ) ξ)
      (Ioc (-(T / 2)) (-(T / 2) + T)) volume := by

  have h1 : Integrable (F : AddCircle T → ℂ) haarAddCircle :=
    (Lp.memLp F).integrable (by norm_num)
  have h2 : Integrable (F : AddCircle T → ℂ) (volume : Measure (AddCircle T)) := by
    rw [AddCircle.volume_eq_smul_haarAddCircle]
    exact h1.smul_measure (by simp)
  exact ((AddCircle.measurePreserving_mk T (-(T / 2))).integrable_comp
    h2.aestronglyMeasurable).mpr h2
