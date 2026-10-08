-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.integrableOn_spectrum
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

theorem BookProof.ChapterShannonSampling.integrableOn_spectrum (F : Lp ℂ 2 (haarAddCircle (T := T))) :
    IntegrableOn (fun ξ : ℝ => (F : AddCircle T → ℂ) ξ)
      (Ioc (-(T / 2)) (-(T / 2) + T)) volume := by sorry
