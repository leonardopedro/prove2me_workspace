-- Generated from ChapterG3.lean — the `PhysHSGaussian` sphere layer that the
-- platform's served ChapterG3 copy predates (§2.13 new-name route:
-- submit-definition rejects an existing name, so the decls live here instead).
-- The three `mehler_uniform_*` statements cite `PhysHSGaussian.sphereUniform`.
import Definitions.Def_ChapterG3
import Mathlib

open MeasureTheory
open scoped ENNReal

namespace BookProof.ChapterG3

namespace PhysHSGaussian

/-- Radial projection onto the sphere of radius `√k` (junk value at 0). -/
noncomputable def sphereProj (k : ℕ) (x : EuclideanSpace ℝ (Fin k)) :
    EuclideanSpace ℝ (Fin k) :=
  if x = 0 then x else (Real.sqrt k / ‖x‖) • x

/-- The uniform measure on the `√k`-sphere, as the push-forward of the standard
Gaussian under the radial projection. -/
noncomputable def sphereUniform (k : ℕ) : MeasureTheory.Measure (EuclideanSpace ℝ (Fin k)) :=
  (gaussianE k).map (sphereProj k)

end PhysHSGaussian

end BookProof.ChapterG3
