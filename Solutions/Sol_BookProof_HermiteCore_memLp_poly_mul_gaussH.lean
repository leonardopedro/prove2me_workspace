-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.memLp_poly_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_continuous_gaussH
import Theorems.Thm_BookProof_HermiteCore_gaussH_sq
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
r (by positivity)

theorem solution (n : ℕ) :
    hermiteNorm n * hermiteNorm n = (n.factorial : ℝ) * Real.sqrt (2 * Real.pi) := by
  have h : (0 : ℝ) ≤ (n.factorial : ℝ) * Real.sqrt (2 * Real. :=
  pi) := by positivity
    rw [hermiteNorm, Real.mul_self_sqrt h]
  
  /-- The normalized Hermite function, as a complex valued function on `ℝ`. -/
  def hermiteC (n : ℕ) : ℝ → ℂ := fun x => ((hermiteFun n x / hermiteNorm n : ℝ) : ℂ)
  
  /-- Any polynomial times the half Gaussian is square integrable. -/
  theorem memLp_poly_mul_gaussH (p : Polynomial ℝ) :
      MemLp (fun x : ℝ => ((p.eval x * gaussH x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by
    have hmeas : AEStronglyMeasurable (fun x : ℝ => ((p.eval x * gaussH x : ℝ) : ℂ))
        (volume : Measure ℝ) := by
      refine Continuous.aestronglyMeasurable ?_
      exact Complex.continuous_ofReal.comp (p
