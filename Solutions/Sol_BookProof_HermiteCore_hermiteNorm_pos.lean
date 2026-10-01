-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteNorm_pos
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
x * (gaussH x * gaussH x) by ring, gaussH_sq]

/-- The `L²` normalizing constant `√(n! √(2π))`. -/
def hermiteN :=
  orm (n : ℕ) : ℝ := Real.sqrt ((n.factorial : ℝ) * Real.sqrt (2 * Real.pi))
  
  theorem hermiteNorm_pos (n : ℕ) : 0 < hermiteNorm
