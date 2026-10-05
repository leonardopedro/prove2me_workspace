-- Generated from ChapterMehlerOrthogonalInvariance.lean — solution of BookProof.ChapterMehlerOrthogonalInvariance.gaussianHead_map_orthogonal
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
import Theorems.Thm_BookProof_ChapterMehlerOrthogonalInvariance_stdGaussianEuclidean_map_isometry
open BookProof.ChapterMehlerOrthogonalInvariance



open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution {k : ℕ} (O : Matrix (Fin k) (Fin k) ℝ)
    (hO : Oᵀ * O = 1) :
    (gaussianHead k).map (fun x => O *ᵥ x) = gaussianHead k := by

  refine (MeasurableEquiv.toLp 2 (Fin k → ℝ)).map_measurableEquiv_injective ?_
  have hmeas : Measurable fun x : Fin k → ℝ => O *ᵥ x := by fun_prop
  rw [MeasurableEquiv.coe_toLp, Measure.map_map (by fun_prop) hmeas]
  have hcomp : (WithLp.toLp 2) ∘ (fun x : Fin k → ℝ => O *ᵥ x)
      = (orthEquiv O hO) ∘ (WithLp.toLp 2) := by
    ext x i
    simp
  rw [hcomp, ← Measure.map_map (by fun_prop) (by fun_prop)]
  exact stdGaussianEuclidean_map_isometry k (orthEquiv O hO)
